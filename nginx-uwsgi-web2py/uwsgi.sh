#!/bin/sh

### BEGIN INIT INFO
# Provides:          uwsgi
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the uwsgi app server
# Description:       starts uwsgi app server using start-stop-daemon
### END INIT INFO

PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin
DAEMON=/usr/local/bin/uwsgi
OWNER=ayrton
NAME=uwsgi
DESC=uwsgi
UWSGI_LOG_FILE=/home/ayrton/www/logs/uwsgi.log
WEB2PY_LOCATION=/home/ayrton/www/web2py

test -x $DAEMON || exit 0
# Include uwsgi defaults if available

if [ -f /etc/default/uwsgi ] ; then
. /etc/default/uwsgi
fi
set -e

DAEMON_OPTS="--socket /tmp/uwsgi.sock --thunder-lock -M -t 30 -A 2 -p 4 -b 65535 -d $UWSGI_LOG_FILE --pythonpath $WEB2PY_LOCATION --module wsgihandler --http-timeout 600 --harakiri 600 --harakiri-verbose"

case "$1" in
        start)
                echo -n "Starting $DESC: "
                start-stop-daemon --start --chuid $OWNER:$OWNER --user $OWNER \
                        --exec $DAEMON -- $DAEMON_OPTS
                echo "$NAME."
                ;;
        stop)
                echo -n "Stopping $DESC: "
                start-stop-daemon --signal 3 --user $OWNER --quiet --retry 2 --stop \
                        --exec $DAEMON
                echo "$NAME."
                ;;
        reload)
                killall -1 $DAEMON
                ;;
        force-reload)
                killall -15 $DAEMON
                ;;
        restart)
                echo -n "Restarting $DESC: "
                start-stop-daemon --signal 3 --user $OWNER --quiet --retry 2 --stop \
                        --exec $DAEMON
                sleep 1
                start-stop-daemon --user $OWNER --start --quiet --chuid $OWNER:$OWNER \
                        --exec $DAEMON -- $DAEMON_OPTS
                echo "$NAME."
                ;;
        status)
                killall -10 $DAEMON
                ;;
        *)
                N=/etc/init.d/$NAME
                echo "Usage: $N {start|stop|restart|reload|force-reload|status}" >&2
                exit 1
                ;;
esac
exit 0
wrap

