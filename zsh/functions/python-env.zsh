#!/bin/zsh
#
# Auto activate a python virtualenv when entering the project directory.
# Installation:
#   source python-env.zsh
#
# Usage:
#   Function `venvconnect`:
#       Connect the currently activated virtualenv to the current directory.
#
VENV_HOME=$HOME/.virtualenvs

function venvconnect() {
    if [[ -n $VIRTUAL_ENV ]]; then
        echo $(basename $VIRTUAL_ENV) > .venv
    else
        echo "Activate a virtualenv first"
    fi
}

function venvnew() {
    if [ -z "$1" ]; then
        echo "Could not create environment: No environment name specified!"
    else
        python3 -m venv $VENV_HOME/$1   
    fi
}

function venvactivate() {
    if [ -z "$1" ]; then
        echo "Could not activate environment: No environment name specified!"
    else
        _VENVPATH=$VENV_HOME/$1
        # Check to see if already activated to avoid redundant activating
        if [[ "$VIRTUAL_ENV" != "$_VENVPATH" ]]; then
            _VENV_ACTIVATE="$_VENVPATH/bin/activate"
            if [ -f $_VENV_ACTIVATE ]; then
                source $_VENV_ACTIVATE
            else
                echo "Could not activate environment $_VENV_PATH"
            fi
        fi
    fi
}

function _virtualenv_auto_activate() {
    if [[ -f ".venv" ]]; then
        venvactivate $(cat .venv)
    fi
}

chpwd_functions+=(_virtualenv_auto_activate)
precmd_functions=(_virtualenv_auto_activate $precmd_functions)
