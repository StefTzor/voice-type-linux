#!/bin/bash
set -e

echo "Detecting Linux distribution..."

if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Cannot detect Linux distribution. Please install dependencies manually."
    exit 1
fi

echo "Detected distro: $DISTRO"

install_deps_apt() {
    sudo apt update
    sudo apt install -y ffmpeg xdotool xclip libnotify-bin python3 python3-venv python3-pip
}

install_deps_pacman() {
    sudo pacman -Sy --noconfirm ffmpeg xdotool xclip libnotify python python-pip
}

install_deps_dnf() {
    sudo dnf install -y ffmpeg xdotool xclip libnotify python3 python3-pip
}

case "$DISTRO" in
    ubuntu|debian)
        install_deps_apt
        ;;
    arch)
        install_deps_pacman
        ;;
    fedora)
        install_deps_dnf
        ;;
    *)
        echo "Unsupported or undetected distro '$DISTRO'. Please install these packages manually:"
        echo "ffmpeg, xdotool, xclip, libnotify, python3, python3-venv, python3-pip"
        ;;
esac

echo "Setting up Python virtual environment..."

python3 -m venv ~/voice-type-env
source ~/voice-type-env/bin/activate

pip install --upgrade pip
pip install openai-whisper

echo "Installation complete."
echo "To start using, activate the virtual environment with:"
echo "  source ~/voice-type-env/bin/activate"
echo "Then run the scripts in bin/: start_voice_type.sh and stop_voice_type.sh"
