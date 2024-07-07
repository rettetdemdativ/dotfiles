username() {
    echo "%n"
}

hostname() {
    echo "%m"
}

directory() {
   echo "%~"
}

# set the git_prompt_info text
ZSH_THEME_GIT_PROMPT_PREFIX=" | "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# putting it all together
PROMPT='$(username)@$(hostname):$(directory)$(git_prompt_info) > '