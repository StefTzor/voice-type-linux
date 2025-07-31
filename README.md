# Voice-Type Linux

🎙️ A simple voice-to-text tool for Linux using Whisper, `ffmpeg`, and X11/Wayland tools.

---

## Features

- Record voice with a global shortcut
- Automatically transcribe audio using OpenAI Whisper
- Type transcription directly into the focused text field
- Copy transcription to clipboard
- Supports X11 (xdotool + xclip) and Wayland (wtype + wl-copy)

---

## Requirements

- Linux distribution with `bash`
- Python 3.8+
- ffmpeg
- xdotool (X11) or wtype (Wayland)
- xclip (X11) or wl-clipboard (Wayland)
- libnotify (`notify-send`)

---

## Installation

1. Clone this repository:

```bash
git clone https://github.com/StefTzor/voice-type-linux.git
cd voice-type-linux
```

2. Run the installer script to install dependencies and set up Python environment:

```bash
./install.sh
```

3. Activate the Python virtual environment:

```bash
source ~/voice-type-env/bin/activate
```

4. Make the scripts executable (if needed):

```bash
chmod +x bin/start_voice_type.sh bin/stop_voice_type.sh
```

---

## Usage

- Start recording:

```bash
./bin/start_voice_type.sh
```

- Stop recording and transcribe:

```bash
./bin/stop_voice_type.sh
```

---

## Setting up Keyboard Shortcuts (Example: KDE)

1. Open **System Settings** > **Shortcuts** > **Custom Shortcuts**.
2. Create a new global shortcut:
   - Trigger: your preferred key combo (e.g., Ctrl+Alt+R) to start recording
   - Action: run command `/path/to/voice-type-linux/bin/start_voice_type.sh`
3. Create another global shortcut:
   - Trigger: another key combo (e.g., Ctrl+Alt+S) to stop recording & transcribe
   - Action: run command `/path/to/voice-type-linux/bin/stop_voice_type.sh`

---

## Notes

- On Wayland, you need `wtype` and `wl-clipboard` installed. On X11, `xdotool` and `xclip` are required.
- If you use another desktop environment, adjust dependencies accordingly.
- The scripts detect if running under Wayland or X11 automatically and switch tools.
- The recorded audio is saved temporarily in `/tmp/voice_input.wav` and transcribed text in `/tmp/voice_input.txt`.
- You can customize recording device in `start_voice_type.sh` if needed.

---

## Troubleshooting

- If transcription doesn’t type correctly, check that `xdotool` or `wtype` is installed and working.
- If clipboard copy fails, verify `xclip` or `wl-copy` availability.
- Notifications require `libnotify` (`notify-send`).
- Make sure your keyboard shortcuts are properly set in your DE.

---

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## Contact

Project Link: [https://github.com/StefTzor/voice-type-linux](https://github.com/StefTzor/voice-type-linux)


