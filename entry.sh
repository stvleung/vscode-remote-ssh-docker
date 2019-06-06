#!/bin/sh

/usr/sbin/groupadd -g ${GID} remote-group
/usr/sbin/useradd -u ${UID} -g ${GID} -M remote-user

exec $@
