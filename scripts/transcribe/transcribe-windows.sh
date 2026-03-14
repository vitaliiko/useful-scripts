#!/usr/bin/env bash
set -euo pipefail

# Windows/Git Bash friendly transcribe script.
# Uses Scoop to install ffmpeg/ffprobe and whisper-cli/whisper-cpp when possible.

INPUT_DIR=${INPUT_DIR:-"./input"}
OUTPUT_DIR=${OUTPUT_DIR:-"./output"}
TARGET_LANG="${1:-${TARGET_LANG:-en}}"
MODEL_NAME=${MODEL_NAME:-"large-v3-turbo"}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODEL_PATH="$SCRIPT_DIR/ggml-$MODEL_NAME.bin"
WHISPER_BIN="${WHISPER_BIN:-}"
WHISPER_CANDIDATES=(whisper-cli whisper whisper-cpp main)
WHISPER_SCOOP_PACKAGES=(whisper whisper-cpp whisper-cli)
SCOOP_EXTRA_BUCKET=extras

have_command() {
    command -v "$1" >/dev/null 2>&1
}

ensure_scoop() {
    if have_command scoop; then
        return 0
    fi
    printf 'Scoop was not found on PATH.\n' >&2
    printf 'Install Scoop from https://scoop.sh/ or manually install ffmpeg, ffprobe, and a whisper CLI.\n' >&2
    return 1
}

ensure_scoop_bucket() {
    local bucket="$1"
    if scoop bucket list 2>/dev/null | grep -Fqx "$bucket"; then
        return 0
    fi
    printf 'Adding Scoop bucket: %s\n' "$bucket"
    scoop bucket add "$bucket"
}

ensure_tool() {
    local cmd="$1"
    local pkg="${2:-$1}"
    if have_command "$cmd"; then
        return 0
    fi
    if ! ensure_scoop; then
        printf 'Missing required command "%s". Install it manually and re-run.\n' "$cmd" >&2
        exit 1
    fi
    printf 'Installing %s via Scoop to provide "%s"...\n' "$pkg" "$cmd"
    if ! scoop install "$pkg"; then
        printf 'Failed to install %s via Scoop. Install "%s" manually and re-run.\n' "$pkg" "$cmd" >&2
        exit 1
    fi
    if ! have_command "$cmd"; then
        printf '"%s" is still unavailable after installing %s. Check your PATH.\n' "$cmd" "$pkg" >&2
        exit 1
    fi
}

find_whisper_command() {
    if [ -n "$WHISPER_BIN" ]; then
        if have_command "$WHISPER_BIN"; then
            printf '%s\n' "$WHISPER_BIN"
            return 0
        fi
        printf 'WHISPER_BIN="%s" was provided but not found on PATH.\n' "$WHISPER_BIN" >&2
        return 1
    fi

    for cand in "${WHISPER_CANDIDATES[@]}"; do
        if have_command "$cand"; then
            printf '%s\n' "$cand"
            return 0
        fi
    done

    return 1
}

ensure_whisper_command() {
    local whisper_cmd
    if whisper_cmd="$(find_whisper_command)"; then
        WHISPER="$whisper_cmd"
        return 0
    fi

    if ! ensure_scoop; then
        printf 'whisper CLI not found and Scoop is unavailable. Install whisper-cpp/whisper-cli manually.\n' >&2
        exit 1
    fi

    ensure_scoop_bucket "$SCOOP_EXTRA_BUCKET"
    for pkg in "${WHISPER_SCOOP_PACKAGES[@]}"; do
        printf 'Attempting to install %s via Scoop...\n' "$pkg"
        if scoop install "$pkg"; then
            if whisper_cmd="$(find_whisper_command)"; then
                WHISPER="$whisper_cmd"
                return 0
            fi
        else
            printf 'Scoop failed to install %s. Continuing...\n' "$pkg" >&2
        fi
    done

    printf 'Unable to locate a whisper CLI even after Scoop installs. Set WHISPER_BIN or install whisper-cpp manually.\n' >&2
    exit 1
}

download_model_if_missing() {
    if [ -f "$MODEL_PATH" ]; then
        return 0
    fi
    printf 'Downloading model %s...\n' "$MODEL_NAME"
    curl -L "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-$MODEL_NAME.bin" -o "$MODEL_PATH"
}

# Ensure base tools
ensure_tool curl curl
ensure_tool ffmpeg ffmpeg
ensure_tool ffprobe ffmpeg
ensure_whisper_command
download_model_if_missing
mkdir -p "$OUTPUT_DIR"

process_file() {
    local file="$1"
    printf '\n--> Processing: %s\n' "$file"

    local has_audio has_video
    has_audio=$(ffprobe -v error -select_streams a -show_entries stream=codec_type -of csv=p=0 "$file" 2>/dev/null || true)
    has_video=$(ffprobe -v error -select_streams v -show_entries stream=codec_type -of csv=p=0 "$file" 2>/dev/null || true)
    if [ -z "$has_audio" ] && [ -z "$has_video" ]; then
        printf '    Skipping: not an audio/video file.\n'
        return 0
    fi

    local base outtxt workdir audio txtfile
    base="$(basename "$file")"
    outtxt="$OUTPUT_DIR/${base%.*}.txt"
    workdir=$(mktemp -d 2>/dev/null || mktemp -d -t whisper)

    audio="$workdir/audio.wav"
    printf '    Extracting mono 16kHz WAV...\n'
    ffmpeg -i "$file" -ar 16000 -ac 1 -c:a pcm_s16le "$audio" -y -loglevel error

    printf '    Transcribing (%s)...\n' "$TARGET_LANG"
    (
        cd "$workdir"
        "$WHISPER" -m "$MODEL_PATH" -f "$audio" -l "$TARGET_LANG" -otxt
    )

    txtfile=$(find "$workdir" -maxdepth 1 -type f -name "*.txt" | head -n1 || true)
    if [ -n "$txtfile" ]; then
        mv "$txtfile" "$outtxt"
        printf '    Wrote: %s\n' "$outtxt"
    else
        printf '    Warning: whisper produced no TXT output.\n'
    fi

    rm -rf "$workdir"
}

if [ ! -d "$INPUT_DIR" ]; then
    printf 'Input directory "%s" does not exist.\n' "$INPUT_DIR" >&2
    exit 1
fi

shopt -s nullglob
files=("$INPUT_DIR"/*)
if [ ${#files[@]} -eq 0 ]; then
    printf 'No files found in %s. Place audio/video files there and rerun.\n' "$INPUT_DIR"
    exit 0
fi

for file in "${files[@]}"; do
    [ -f "$file" ] || continue
    process_file "$file"
done

printf '\nAll done. Transcripts are in %s\n' "$OUTPUT_DIR"
