#!/usr/bin/env zsh

typeset -U PATH path

export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2  | tr '\n' ':' | sed 's/:*$//')"
#:$HOME/.local/share/cargo/bin"
#export PATH="$PATH:$(du "$HOME/.local/share/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH=$HOME/.nix-profile:$PATH
export PATH=$HOME/.local/share/JetBrains/Toolbox/scripts:$PATH
unsetopt PROMPT_SP

export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export INPUTRC="${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="/run/user/$UID"
export XDG_STATE_HOME="$HOME/.local/state"

export EDITOR="nvim"
export VISUAL="nvim"
#export FILE="lf"
export FILE="ranger"
export TERMINAL="wezterm"
# export TERMINAL="st"
export READER="Okular"
export BROWSER="librewolf"
export PRINTER="mfp-m281"
export OPENER="xdg-open"
export COLORTERM="truecolor"
#export WM="bspwm"
export STATUSBAR="polybar"
export MAILTO="svs3"
export PAGER="nvimpager"
export MANPAGER="less"
export MANWIDTH=999

export PGDATA="/home/svs3/postgres/data"

#export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"	# This line will break some DMs.
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export GTK3_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-3.0/gtkrc-3.0"
export GTK4_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-4.0/gtkrc-4.0"
export LESSHISTORY=-
export DOOMDIR="${XDG_CONFIG_HOME:-$HOME/.config}/doom"
export INFOPATH="$HOME/info"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.conifg}/zsh"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export WINEPREFIX="${XDG_DATA_HOME:-$HOME/.local/share}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME:-$HOME/.local/share}/kodi"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/pass"
export PASSWORD_STORE_EXTENSIONS_DIR="${PASSWORD_STORE_DIR}/.extensions"
export PASSWORD_STORE_ENABLE_EXTENSIONS="true"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/android"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export XDEB_PGKROOT="${XDG_CONFIG_HOME:-$HOME/.config}/xdeb"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/ansible/ansilble.cfg"
export UNISON="${XDG_DATA_HOME:-$HOME/.local/share}/unison"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/history"
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Other program settings:
export $(dbus-launch)
export DICS="/usr/share/stardict/dic/"
#export SXHKD_SHELL="/bin/zsh"
#export SUDO_ASKPASS="$HOME/.local/bin/dmenupass"
export FZF_DEFAULT_OPS="--layout=reverse --height 40%"
export FZF_DEFAULT_COMMAND="fd --type f"
export LESS=-R
export LESS_TERMCAP_mb=$(printf '%b' '\e[1;31m')
export LESS_TERMCAP_md=$(printf '%b' '\e[1;36m')
export LESS_TERMCAP_me=$(printf '%b' '\e[0m')
export LESS_TERMCAP_so=$(printf '%b' '\e[01;44;33m')
export LESS_TERMCAP_se=$(printf '%b' '\e[0m')
export LESS_TERMCAP_us=$(printf '%b' '\e[1;32m')
export LESS_TERMCAP_ue=$(printf '%b' '\e[0m')
export LESSOPEN="| /usr/bin/highlight -O ansi %s 2>/dev/null"
export QT_QPA_PLATFORMTHEME="gtk2"
export MOZ_USE_XINPUT2="1"
export AWT_TOOLKIT="MToolkit wmname LG3D"
export _JAVA_AWT_WM_NONREPARENTING=1
#export JAVA_HOME="/usr/lib/jvm/jbdsdk/"
#export CLION_JDK="/usr/lib/jvm/jbrsdk/"
export DIRSTACKFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/dirs"

# xdeb settings
export XDEB_PKGROOT="${XDG_DATA_HOME:-$HOME/.local/share}/xdeb"
export XDEB_OPT_DEPS=true
export XDEB_OPT_SYNC=true
export XDEB_OPT_WARN_CONFLICT=true
export XDEB_OPT_FIX_CONFLICT=true

# optional lua variables:
export LUAMB_DIR="{XDG_DATA_HOME:-$HOME/.local/share}/luambenvs"
export LUAMB_LUA_DEFAULT="lua 5.4"     # default Lua version
export LUAMB_LUAROCKS_DEFAULT=latest   # default LuaRocks version
LUAMB_DISABLE_COMPLETION=true          # disable shell completions
LUAMB_PYTHON_BIN=/usr/bin/python3      # explicitly set Python executable

# This is the list for lf icons:
export LF_ICONS="di=📁:\
fi=📃:\
tw=🤝:\
ow=📂:\
ln=⛓:\
or=❌:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=🖼:\
*.webp=🖼:\
*.ico=🖼:\
*.jpg=📸:\
*.jpe=📸:\
*.jpeg=📸:\
*.gif=🖼:\
*.svg=🗺:\
*.tif=🖼:\
*.tiff=🖼:\
*.xcf=🖌:\
*.html=🌎:\
*.xml=📰:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=📚:\
*.djvu=📚:\
*.epub=📚:\
*.csv=📓:\
*.xlsx=📓:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.mkv=🎥:\
*.mp4=🎥:\
*.webm=🎥:\
*.mpeg=🎥:\
*.avi=🎥:\
*.zip=📦:\
*.rar=📦:\
*.7z=📦:\
*.tar.gz=📦:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=📙:\
*.iso=📀:\
*.img=📀:\
*.bib=🎓:\
*.ged=👪:\
*.part=💔:\
*.torrent=🔽:\
*.jar=♨:\
*.java=♨:\
"

[ ! -f ${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc ] && shortcuts >/dev/null 2>&1 &
#source "/home/svs3/.local/share/cargo/env"
