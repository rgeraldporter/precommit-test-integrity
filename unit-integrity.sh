#!/bin/sh

bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
white=$(tput setaf 7)
blue=$(tput setaf 4)
grey=$(tput setaf 251)

STATUS=0

tag="${blue}${bold}[Unit Test Integrity]${white}${normal}:";

declare -a foci=('fdescribe' 'fcontext' 'fit' 'fspecify' 'fexample')

for focus in "${foci[@]}"; do

    #staged
    FILES=$(git diff --staged -G"^\s*$focus\(" --name-only | wc -l)

    if [ $FILES -gt 0 ]
    then
        echo "\n${tag} ${red}${bold}$focus${white}${normal} was found in the following files:\n"
        git --no-pager diff --staged --name-only -G"^\s*$focus\("
        STATUS=1
    fi

    #unstaged
    FILES=$(git diff -G"^\s*$focus\(" --name-only | wc -l)

    if [ $FILES -gt 0 ]
    then
        echo "\n${tag} ${red}${bold}$focus${white}${normal} was found in the following files:\n"
        git --no-pager diff --name-only -G"^\s*$focus\("
        STATUS=1
    fi
done

if [ $STATUS -eq 1 ]
then
    echo "\n${tag} ❌  ${red}Focused cases found in spec files to be committed."
    echo "${tag} Please remove these and re-commit.\n"
    exit 1
fi

echo "\n${tag} ✅  ${green}No focused cases found in spec files to be committed.\n"
