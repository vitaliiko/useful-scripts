#!/bin/bash

VIDEO_FILE=$1
LANG=${2:-en}
MODEL_NAME="large-v3-turbo"
MODEL_PATH="./ggml-$MODEL_NAME.bin"
AUDIO_FILE="temp_audio.wav"

# --- 1. FIND THE COMMAND ---
# Check common names and common M1 paths
if command -v whisper-cli &> /dev/null; then WHISPER="whisper-cli"
elif [ -f "/opt/homebrew/bin/whisper-cli" ]; then WHISPER="/opt/homebrew/bin/whisper-cli"
elif [ -f "/opt/homebrew/bin/whisper-cpp" ]; then WHISPER="/opt/homebrew/bin/whisper-cpp"
else
    echo "❌ Error: Could not find whisper-cli."
    echo "Try running: brew link whisper-cpp"
    exit 1
fi

# --- 2. VALIDATE INPUT ---
if [ -z "$VIDEO_FILE" ]; then
    echo "Usage: ./transcribe.sh <video_file> [language]"
    exit 1
fi

# --- 3. DOWNLOAD MODEL ---
if [ ! -f "$MODEL_PATH" ]; then
    echo "📥 Downloading $MODEL_NAME model..."
    curl -L "https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-$MODEL_NAME.bin" -o "$MODEL_PATH"
fi

# --- 4. PREPARE AUDIO ---
echo "⚙️  Extracting audio..."
ffmpeg -i "$VIDEO_FILE" -ar 16000 -ac 1 -c:a pcm_s16le "$AUDIO_FILE" -y -loglevel error

# --- 5. TRANSCRIBE ---
echo "📝 Transcribing [${LANG}]..."
# On M1, we also set an ENV variable to ensure Metal (GPU) is active
GGML_METAL_PATH_RESOURCES="$(brew --prefix whisper-cpp)/share/whisper-cpp" \
$WHISPER -m "$MODEL_PATH" -f "$AUDIO_FILE" -l "$LANG" -otxt

# --- 6. CLEANUP ---
rm "$AUDIO_FILE"
echo "✅ Done! Created: ${VIDEO_FILE}.txt"
