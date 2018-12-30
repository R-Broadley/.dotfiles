#!/usr/bin/env python3

import sys
import os
from os.path import expanduser, join


DOTFILES = expanduser('~/.dotfiles')

ZSHRC = expanduser('~/.zshrc')
ZSHDEST = expanduser('~/.zsh')
ZSHSRC = join(DOTFILES, 'zsh')
FONTDEST = expanduser('~/.fonts')
FONTSRC = join(DOTFILES, 'fonts')

COMMANDS = ['install', 'remove']
DEPENDENCIES_MAP = {
    'zsh': ['zsh', 'fonts'],
    'fonts': ['fonts']
}
MODULES_MAP = {
    'zsh': 'ZSHRC={} ZSHDEST={} ZSHSRC={}'.format(ZSHRC, ZSHDEST, ZSHSRC),
    'fonts': 'FONTDEST={} FONTSRC={}'.format(FONTDEST, FONTSRC)
}


def app_exit(code):
    print('Exiting...')
    sys.exit(code)


def binary_question(question):
    accepted = False
    while not accepted:
        response = input('{}\n(y/n) '.format(question))
        if response in ['Y', 'y', 'Yes', 'yes']:
            result = True
            accepted = True
        elif response in ['N', 'n', 'No', 'no']:
            result = False
            accepted = True
        else:
            print('Response must be "y" or "n".')
    return result


def resolve_dependencies(chosen_modules, command):
    requirements = []
    if command == 'install':
        for module in chosen_modules:
                requirements += DEPENDENCIES_MAP[module]
    elif command == 'remove':
        for module, dependencies in DEPENDENCIES_MAP.items():
            if len(set(chosen_modules).intersection(dependencies)) > 0:
                requirements.append(module)
    return set(requirements)


def main(argv):
    args = argv.copy()
    try:
        command = args.pop(0)
    except IndexError:
        print("No Command given!")
        app_exit(1)
    if command not in COMMANDS:
        print("Accepted commands are 'install' or 'remove'")
        app_exit(1)

    if len(args) < 1:
        chosen_modules = set(DEPENDENCIES_MAP)
    else:
        chosen_modules = args
    
    try:
        requirements = resolve_dependencies(chosen_modules, command)
    except KeyError:
        bad_args = set(args) - set(DEPENDENCIES_MAP)
        for arg in bad_args:
            print("Bad option: {}".format(arg))
        app_exit(1)
    
    result = binary_question(
        '{} the following modules? {}'
        .format(command.capitalize(), requirements)
    )
    if not result:
        app_exit(0)

    if command == 'install':
        os.system('git submodule update --init --recursive')

    for module in requirements:
        playbook = (
            '{module}/{module}-{command}.yml'
            .format(module=module, command=command)
        )
        if 'become: yes' in open(playbook).read():
            ansible_run = 'sudo ansible-playbook'
        else:
            ansible_run = 'ansible-playbook'
        os.system(
            '{ansible_run} "{playbook}" --extra-vars "{exvars}"'
            .format(
                ansible_run=ansible_run,
                playbook=playbook,
                exvars=MODULES_MAP[module]
            )
        )


if __name__ == "__main__":
   main(sys.argv[1:])
