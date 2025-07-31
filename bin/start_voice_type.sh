#!/bin/bash
# Start voice recording and save PID & file path

rm -f /tmp/voice_input.wav /tmp/voice_rec_pid /tmp/voice_rec_path

ffmpeg -f alsa -i default -ac 1 -ar 16000 /tmp/voice_input.wav &
echo $! > /tmp/voice_rec_pid
echo "/tmp/voice_input.wav" > /tmp/voice_rec_path

notify-send "Voice to Text" "🎙️ Recording started. Speak now!"
