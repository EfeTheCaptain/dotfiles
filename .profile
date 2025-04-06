if [ -f "$HOME/.env" ]; then
	source "$HOME/.env"
fi

export QTWEBENGINE_CHROMIUM_FLAGS=--blink-settings=forceDarkModeEnabled=true
. "/home/efe/Projects/rs/cargo/env"
