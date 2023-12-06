setopt prompt_subst
autoload -Uz vcs_info

# purple username
username() {
   echo "%{$FG[088]%}%n%{$reset_color%}"
}

# current directory
function directory() {
   local color="%{$fg_no_bold[cyan]%}";
   local dir="${PWD/#$HOME/~}";
   local tilde
   if [[ $dir == "~"* ]]; then
      tilde="~"
   fi
   echo "${color}%(4~|$tilde/../%2~|$dir)"; #
}

# current time with milliseconds
function current_time() {
   echo "%*"
}

# returns a red  if there are errors and a green  if there aren't
function return_status() {
   echo "%(?.%{$fg[green]%}.%{$fg[red]%})"
}

# returns OS indicator and (bolded) username
function get_os() {
    local color="%{$fg_no_bold[cyan]%}";                    # color in PROMPT need format in %{XXX%} which is not same with echo
    local os
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # Linux
        os="󰌽"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        os=""
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
    elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
    else
        # Unknown.
    fi
    echo "$os ${color}%B%{$FG[116]%}%n%{$reset_color%}";
}


# set the git_prompt_info text
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$FG[214]%}%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[cyan]%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} "

# putting it all together
PROMPT='$(get_os) $(directory) $(git_prompt_info)%b '
RPROMPT=' $(current_time) %(?..%{$fg[red]%}%?%{$reset_color%} )$(return_status)%{$reset_color%}'
