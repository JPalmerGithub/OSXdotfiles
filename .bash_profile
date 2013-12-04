#!/bin/bash
# Add `~/bin` to the `$PATH`
export PATH="$PATH:~:~/bin:~/Applications:/bin:/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/opt/X11/bin:/Applications"
export PATH="$PATH:$HOME/bin:$HOME/.rvm/bin:/Applications/Utilities"
export PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Prefer US English and use UTF-8
export LANG="en_US"
export LC_ALL="en_US.UTF-8"
export LANG='en_GB'
# Set Less as the default pager
export PAGER='less -M -N'

# Set the Standard Editor as Sublime Text
# (Symlink to subl created in ~/bin, app located in /Applications/Sublime Text/Contents/SharedSupport/bin/)
export VISUAL='subl'
export EDITOR='subl'

# History File Manipulation

# Expand "!" history when pressing space
# bind Space:magic-space

# When the command contains an invalid history operation (for instance when
# using an unescaped "!" (I get that a lot in quick e-mails and commit
# messages) or a failed substitution (e.g. "^foo^bar" when there was no "foo"
# in the previous command line), do not throw away the command line, but let me
# correct it.
shopt -s histreedit

# Keep track of the time the commands were executed.
# The xterm colour escapes require special care when piping; e.g. "| less -R".
export HISTTIMEFORMAT="${FG_BLUE}${FONT_BOLD}%Y/%m/%d %H:%M:%S${FONT_RESET} "

# Hist length and filesize
export HISTSIZE=1000
export HISTFILESIZE=$HISTSIZE
# Below ignores both Dups and space first commands
export HISTCONTROL=ignoreboth
# Ignore common commands
export HISTIGNORE="ls:cls:clear:pwd:exit:date:* --help"
# Make new shells get the history lines from all previous
# shells instead of the default "last window closed" history
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Do not overwrite files when redirecting using ">", ">&" or "<>".
# Note that you can still override this with ">|".
set -o noclobber

# Autocorrect typos in path names when using the `cd` command
shopt -s cdspell

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS
shopt -s checkwinsize

# Save all lines of a multiple-line command in the same history entry
shopt -s cmdhist

# Include filenames beginning with a "." in the filename expansion
shopt -s dotglob

# Use extended pattern matching features
shopt -s extglob

# Do not attempt to search the PATH for possible
# completions when completion is attempted on an empty line
shopt -s no_empty_cmd_completion

# Match filenames in a case-insensitive
# fashion when performing filename expansion
shopt -s nocaseglob

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Highlight section titles in manual pages
export LESS_TERMCAP_md="$ORANGE"
# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

# Always enable colored `grep` output
export GREP_OPTIONS="--color=auto"

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

# Adding Brew Source for Brew auto completion
source `brew --repository`/Library/Contributions/brew_bash_completion.sh

# If possible, add tab completion for many more commands
[ -f /etc/bash_completion ] && source /etc/bash_completion
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Make the "sudo" prompt more useful, without requiring access to "visudo".
export SUDO_PROMPT='[sudo] password for %u on %h: '

archey.sh