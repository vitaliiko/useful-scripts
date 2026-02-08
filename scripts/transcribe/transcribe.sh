#!/bin/bash
set -euo pipefail

# Universal transcribe script
# Reads all files from ./input and writes transcripts to ./output

INPUT_DIR="./input"
OUTPUT_DIR="./output"
LANG=${1:-en}
MODEL_NAME="large-v3-turbo"
# Resolve script directory and use absolute model path so that
# running the script from other working directories (or after cd) still finds the model
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODEL_PATH="$SCRIPT_DIR/ggml-$MODEL_NAME.bin"

### Ensure required tools are installed (attempt via Homebrew on macOS)
ensure_brew_install() {
    pkg="$1"
    echo "Installing $pkg via brew..."
    if ! brew list "$pkg" &>/dev/null; then
        brew install "$pkg" || true
    fi
}

# prefer any of these CLI frontends
WHISPER_CANDS=(whisper-cli /opt/homebrew/bin/whisper-cli /opt/homebrew/bin/whisper-cpp whisper)

check_and_install_tools() {
    missing=()
    # check for ffmpeg/ffprobe
    if ! command -v ffmpeg &>/dev/null; then
        missing+=(ffmpeg)
    fi
    if ! command -v ffprobe &>/dev/null; then
        missing+=(ffmpeg)
    fi

    # check for whisper frontends
    have_whisper=false
    for c in "${WHISPER_CANDS[@]}"; do
        if command -v "$c" &>/dev/null || [ -x "$c" ]; then
            have_whisper=true
            break
        fi
    done
    if [ "$have_whisper" = false ]; then
        missing+=(whisper)
    fi

    if [ ${#missing[@]} -eq 0 ]; then
        return 0
    fi

    # Try Homebrew on macOS
    if command -v brew &>/dev/null; then
        echo "Homebrew detected — attempting to install missing packages: ${missing[*]}"
        for pkg in "${missing[@]}"; do
            case "$pkg" in
                ffmpeg)
                    ensure_brew_install ffmpeg
                    ;;
                whisper)
                    # try common brew formula names for whisper.cpp
                    brew install whisper-cpp 2>/dev/null || \
                    brew install whisper-cli 2>/dev/null || \
                    brew install ggerganov/whisper.cpp/whisper.cpp 2>/dev/null || \
                    echo "Could not install whisper-cpp via brew automatically."
                    ;;
            esac
        done
    else
        echo "No Homebrew found. Automatic install is supported only on macOS with Homebrew."
        echo "Please install ffmpeg and whisper-cpp (or whisper-cli) manually."
    fi
}

# run installs if needed
check_and_install_tools

# --- 1. FIND THE COMMAND ---
if command -v whisper-cli &> /dev/null; then WHISPER="whisper-cli"
elif [ -x "/opt/homebrew/bin/whisper-cli" ]; then WHISPER="/opt/homebrew/bin/whisper-cli"
elif [ -x "/opt/homebrew/bin/whisper-cpp" ]; then WHISPER="/opt/homebrew/bin/whisper-cpp"
elif command -v whisper &> /dev/null; then WHISPER="whisper"
else
    echo "❌ Error: Could not find whisper-cli/whisper-cpp/whisper after attempted install."
    echo "Please install whisper-cpp or whisper-cli and re-run the script."
    exit 1
fi

# --- 2. CHECK TOOLS ---
if ! command -v ffmpeg &> /dev/null; then
    echo "❌ Error: ffmpeg is required but not found after attempted install."
    exit 1
fi
if ! command -v ffprobe &> /dev/null; then
    echo "❌ Error: ffprobe is required but not found after attempted install."
    exit 1
fi

# --- 3. DOWNLOAD MODEL IF MISSING ---
if [ ! -f "$MODEL_PATH" ]; then
        echo "📥 Downloading $MODEL_NAME model..."
        curl -L "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-$MODEL_NAME.bin" -o "$MODEL_PATH"
fi

mkdir -p "$OUTPUT_DIR"

# --- 4. PROCESS ALL FILES IN INPUT ---
shopt -s nullglob
for file in "$INPUT_DIR"/*; do
    [ -f "$file" ] || continue
    echo "\n➡️  Processing: $file"

    # detect audio/video streams
    has_audio=$(ffprobe -v error -select_streams a -show_entries stream=codec_type -of csv=p=0 "$file" 2>/dev/null || true)
    has_video=$(ffprobe -v error -select_streams v -show_entries stream=codec_type -of csv=p=0 "$file" 2>/dev/null || true)

    if [ -z "$has_audio" ] && [ -z "$has_video" ]; then
        echo "   ⚠️  Skipping (not audio/video): $file"
        continue
    fi

    base=$(basename "$file")
    outtxt="$OUTPUT_DIR/${base%.*}.txt"

    # create isolated workdir per file to capture whisper output
    workdir=$(mktemp -d)

    audio="$workdir/audio.wav"
    echo "   ⚙️  Extracting audio to WAV (16kHz mono)..."
    ffmpeg -i "$file" -ar 16000 -ac 1 -c:a pcm_s16le "$audio" -y -loglevel error

    echo "   📝 Transcribing [${LANG}]..."
    (cd "$workdir"
        GGML_METAL_PATH_RESOURCES="$(brew --prefix whisper-cpp 2>/dev/null || true)/share/whisper-cpp" \
        $WHISPER -m "$MODEL_PATH" -f "$audio" -l "$LANG" -otxt
    )

    # move produced .txt (if any) to output with cleaned name
    txtfile=$(find "$workdir" -maxdepth 1 -type f -name "*.txt" | head -n1 || true)
    if [ -n "$txtfile" ]; then
        mv "$txtfile" "$outtxt"
        echo "   ✅ Created: $outtxt"
    else
        echo "   ⚠️  No transcription produced for: $file"
    fi

    rm -rf "$workdir"
done

echo "\nAll done. Transcripts are in: $OUTPUT_DIR"
