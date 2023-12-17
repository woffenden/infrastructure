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
for file in "${HOME}"/.devcontainer/feature-completion/*.sh; do
  source "${file}"
done

####################
# First Notice
####################
if [ -t 1 ] && [[ "${TERM_PROGRAM}" = "vscode" || "${TERM_PROGRAM}" = "codespaces" ]] && [ ! -f "$HOME/.config/vscode-dev-containers/first-run-notice-already-displayed" ]; then
    if [ -f "/usr/local/etc/vscode-dev-containers/first-run-notice.txt" ]; then
        cat "/usr/local/etc/vscode-dev-containers/first-run-notice.txt"
    elif [ -f "/workspaces/.codespaces/shared/first-run-notice.txt" ]; then
        cat "/workspaces/.codespaces/shared/first-run-notice.txt"
    fi
    mkdir -p "$HOME/.config/vscode-dev-containers"
    # Mark first run notice as displayed after 10s to avoid problems with fast terminal refreshes hiding it
    ((sleep 10s; touch "$HOME/.config/vscode-dev-containers/first-run-notice-already-displayed") &)
fi

####################
# Default Editor
####################
if [[ -z "$(git config --get core.editor)" ]] && [[ -z "${GIT_EDITOR}" ]]; then
  if  [ "${TERM_PROGRAM}" = "vscode" ]; then
    if [[ -n $(command -v code-insiders) &&  -z $(command -v code) ]]; then
      export GIT_EDITOR="code-insiders --wait"
    else
      export GIT_EDITOR="code --wait"
    fi
  fi
fi
