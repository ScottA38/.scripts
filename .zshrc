PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{yellow}%~%f%b %# '

HISTFILE=$HOME/.zsh_history

#For when you forget to cd
setopt AUTO_CD

#deactivate case-sensitive globbing default
unsetopt CASE_GLOB

#Formats history entries more nicely
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
#verify history-substituted command before running
setopt HIST_VERIFY

#allows the user to cycle through autocomplete options by continuing to press the autocomplete button
setopt MENU_COMPLETE
