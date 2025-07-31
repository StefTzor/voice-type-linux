#!/bin/bash

export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)

if [[ ! -f /tmp/voice_rec_pid ]]; then
  notify-send "Voice to Text" "❌ Error: Recording PID file not found!"
  exit 1
fi

if [[ ! -f /tmp/voice_rec_path ]]; then
  notify-send "Voice to Text" "❌ Error: Recording file path not found!"
  exit 1
fi

RECORD_FILE=$(cat /tmp/voice_rec_path)
TRANSCRIPT_PATH="${RECORD_FILE%.wav}.txt"

if ! ps -p $(cat /tmp/voice_rec_pid) > /dev/null 2>&1; then
  notify-send "Voice to Text" "⚠️ Warning: No active ffmpeg process found!"
  rm -f /tmp/voice_rec_pid /tmp/voice_rec_path
  exit 1
fi

pkill -INT -F /tmp/voice_rec_pid
sleep 3

if ps -p $(cat /tmp/voice_rec_pid) > /dev/null 2>&1; then
  notify-send "Voice to Text" "⚠️ Warning: ffmpeg still running!"
  exit 1
fi

rm -f /tmp/voice_rec_pid /tmp/voice_rec_path

if [[ ! -f "$RECORD_FILE" ]]; then
  notify-send "Voice to Text" "❌ Error: Recording file not found!"
  exit 1
fi

ls -lh "$RECORD_FILE"
stat "$RECORD_FILE"

source ~/voice-type-env/bin/activate

whisper "$RECORD_FILE" --language en --model base --fp16 False --output_format txt --output_dir /tmp

if [[ ! -f "$TRANSCRIPT_PATH" ]]; then
    notify-send "Voice to Text" "❌ Error: transcript file not found!"
    exit 1
fi

# Detect if running under Wayland or X11 and choose tools accordingly
if [[ "$WAYLAND_DISPLAY" != "" ]]; then
  # Wayland environment
  TYPE_TOOL="wtype"
  CLIP_TOOL="wl-copy"
else
  # Assume X11 environment
  TYPE_TOOL="xdotool"
  CLIP_TOOL="xclip -selection clipboard"
fi

# Sanitize newlines to avoid accidental Enter key triggers
TEXT=$(tr '\n\r' ' ' < "$TRANSCRIPT_PATH")

# Type out the transcription
$TYPE_TOOL type --delay 50 "$TEXT"

# Copy to clipboard
echo "$TEXT" | $CLIP_TOOL

notify-send "Voice to Text" "✅ Transcription typed and copied to clipboard!"
