#/usr/bin/env bash

# Generate a list of filepath elements
_back_completions()
{
	COMPREPLY=($(compgen -W "$(PWD | tr "/" " ")" "${COMP_WORDS[1]}"))
}

complete -F _back_completions back
