####################
# Oh My ZSH Internals
####################
export ZSH="${HOME}/.oh-my-zsh"
export ZSH_THEME="woffenden"
export plugins=(git)

source "${ZSH}/oh-my-zsh.sh"

####################
# Oh My ZSH Options
####################
export DISABLE_AUTO_UPDATE="true"
export DISABLE_UPDATE_PROMPT="true"

####################
# Shell Completion
####################
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

####################
# Feature Completion
####################
for file in "${HOME}"/.devcontainer/featurerc.d/*.sh; do
  source "${file}"
done
