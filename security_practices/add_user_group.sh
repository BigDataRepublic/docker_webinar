#!/bin/sh

username="dockerapp"
groupname="dockerapp"
uid=1777
gid=1777

echoerr() { echo "$@" 1>&2; }

# Debian code.
if [ "$(uname -o)" = "GNU/Linux" ]; then
    echo "Debian detected. Adding group and user."
    # Add the group then the user.
    addgroup --system --gid $gid $groupname \
    && adduser --system --gid $gid --uid $uid --disabled-password --gecos "" --no-create-home --disabled-login $username
    if [ "$?" != "0" ]; then
        echoerr "ERROR, adding user '${username}' and group '${groupname}' failed using the Debian code."
        exit 1
    fi
# Alpine code.
else
    echo "Alpine detected. Adding group and user."
    # Add the group then the user.
    addgroup --gid $gid --system $groupname \
    && adduser --system --ingroup $groupname --uid $uid --disabled-password --gecos "" --no-create-home -s /dev/null $username
    if [ "$?" != "0" ]; then
        echoerr "ERROR, adding user '${username}' and group '${groupname}' failed using the Alpine code."
        exit 1
    fi
fi

exit 0