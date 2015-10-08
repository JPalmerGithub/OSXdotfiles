#!/bin/bash

#  ---------------------------------------------------------------------------
#
#  Description:  This file holds all my BASH configurations and aliases
#
#  Sections:
#  1.   Environment Configuration
#  2.   Make Terminal Better (remapping defaults and adding functionality)
#  3.   File and Folder Management
#  4.   Searching
#  5.   Process Management
#  6.   Networking
#  7.   System Operations & Information
#  8.   Web/programming  Development
#  9.   Reminders & Notes
#
#  ---------------------------------------------------------------------------

#   -------------------------------
#   1.  ENVIRONMENT CONFIGURATION
#   -------------------------------

#    Load the shell dotfiles, and then some:
#    * ~/.path can be used to extend `$PATH`.
#    * ~/.extra can be used for other settings you don’t want to commit.

    for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
        [ -r "$file" ] && [ -f "$file" ] && source "$file"
    done
    unset file

    
#   Set Paths
#   ------------------------------------------------------------
#   All Paths are now located in .path    
#   All Exports (Where Convienient) are located in .exports
#   ------------------------------------------------------------

    shopt -s histreedit

#   Append to the Bash history file, rather than overwriting it
    shopt -s histappend

#   Do not overwrite files when redirecting using ">", ">&" or "<>".
#   Note that you can still override this with ">|".
    set -o noclobber

#   Autocorrect typos in path names when using the `cd` command
    shopt -s cdspell

#   Check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS
    shopt -s checkwinsize

#   Save all lines of a multiple-line command in the same history entry
    shopt -s cmdhist

#   Include filenames beginning with a "." in the filename expansion
    shopt -s dotglob

#   Use extended pattern matching features
    shopt -s extglob

#   Do not attempt to search the PATH for possible
#   completions when completion is attempted on an empty line
    shopt -s no_empty_cmd_completion

#   Match filenames in a case-insensitive
#   fashion when performing filename expansion
    shopt -s nocaseglob

#   Enable some Bash 4 features when possible:
#   * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
#   * Recursive globbing, e.g. `echo **/*.txt`
    for option in autocd globstar; do
        shopt -s "$option" 2> /dev/null
    done

#   Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
    [ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

#   Add tab completion for `defaults read|write NSGlobalDomain`
#   You could just use `-g` instead, but I like being explicit
    complete -W "NSGlobalDomain" defaults

#   Add `killall` tab completion for common apps
    complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

#   Adding Brew Source for Brew auto completion
    source `brew --repository`/Library/Contributions/brew_bash_completion.sh

#   If possible, add tab completion for many more commands
    [ -f /etc/bash_completion ] && source /etc/bash_completion
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

#   -----------------------------
#   2.  MAKE TERMINAL BETTER
#   -----------------------------

#   Aliases are now in .aliases external File

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#   Call my Archey app for machine information on first open of any shell window
#   ------------------------------------------------------------
    ./.archey.sh

#   -------------------------------
#   3.  FILE AND FOLDER MANAGEMENT
#   -------------------------------

#   Aliases are now in .aliases external File

#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

#   Aliases are now in .aliases external File

#   ---------------------------
#   5.  PROCESS MANAGEMENT
#   ---------------------------

#   Aliases are now in .aliases external File

#   ---------------------------
#   6.  NETWORKING
#   ---------------------------

#   Aliases are now in .aliases external File

#   ---------------------------------------
#   7.  SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

#   Aliases are now in .aliases external File

#   ---------------------------------------
#   8.  WEB DEVELOPMENT
#   ---------------------------------------

#   Aliases are now in .aliases external File

#   ---------------------------------------
#   9.  REMINDERS & NOTES
#   ---------------------------------------

#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3

#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage

#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat

#   Make a bootable USB stick in OSX
#   ---------------------------------------
#   Convert .iso/.dmg files to .img using the convert option of hdiutil e.g.,
#
#   hdiutil convert -format UDRW -o ~/path/to/target.img ~/path/to/ubuntu.iso
#      Note: OS X tends to put the .dmg ending on the output file automatically.
#   Run "diskutil list"
#      to get the current list of devices.
#   Insert your flash media.
#   Run "diskutil list"
#      again and determine the device node assigned to your flash media (e.g. /dev/disk2).
#   Run "diskutil unmountDisk /dev/diskN"
#        (replace N with the disk number from the last command; in the previous example, N would be 2).
#   Execute "sudo dd if=/path/to/downloaded.img of=/dev/rdiskN bs=1m"
#        (replace /path/to/downloaded.img with the path where the image file is located; for example, ./ubuntu.img or ./ubuntu.dmg).
#        Using /dev/rdisk instead of /dev/disk may be faster
#        If you see the error dd: Invalid number '1m', you are using GNU dd. Use the same command but replace bs=1m with bs=1M
#        If you see the error dd: /dev/diskN: Resource busy, make sure the disk is not in use. Start the 'Disk Utility.app' and unmount (don't eject) the drive
#   Run "diskutil eject /dev/diskN"
#        and remove your flash media when the command completes.