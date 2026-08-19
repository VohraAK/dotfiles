# Starship prompt
eval "$(starship init bash)"

# Syntax highlighting (bash equivalent)
if [ -f /opt/homebrew/Cellar/bash-syntax-highlighting/0.8.0/share/bash-syntax-highlighting/bash-syntax-highlighting.sh ]; then
    source /opt/homebrew/Cellar/bash-syntax-highlighting/0.8.0/share/bash-syntax-highlighting/bash-syntax-highlighting.sh
elif [ -f /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh ]; then
    source /usr/share/bash-syntax-highlighting/bash-syntax-highlighting.sh
fi

# Conda initialization
__conda_setup="$('/opt/homebrew/Caskroom/miniforge/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup

# Aliases
alias rstudio='open -a RStudio'

export READ_ONCE_DIFF=1
export PATH="$HOME/.local/bin:$PATH"

# Android SDK / Java (JDK 21 via Android Studio's bundled JBR)
export ANDROID_HOME="$HOME/Library/Android/sdk"
export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$JAVA_HOME/bin:$PATH"