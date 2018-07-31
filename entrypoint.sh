#!/bin/bash

set -o errexit
#set -o nounset

readonly RSYSLOG_PID="/var/run/rsyslogd.pid"


main() {
    sed -i -e "s/\${SERVICE_NAME}/$SERVICE_NAME/g" /usr/local/etc/haproxy/haproxy.cfg
    sed -i -e "s/\${SERVICE_PORT}/$SERVICE_PORT/g" /usr/local/etc/haproxy/haproxy.cfg
    sed -i -e "s/\${SERVICE_COUNT}/$SERVICE_COUNT/g" /usr/local/etc/haproxy/haproxy.cfg
    sed -i -e "s/\${SERVICE_MAXCONN}/$SERVICE_MAXCONN/g" /usr/local/etc/haproxy/haproxy.cfg
    sed -i -e "s/\${SERVICE_HEALTH}/$SERVICE_HEALTH/g" /usr/local/etc/haproxy/haproxy.cfg
    if [ -z "$SERVICE_HOST_NAME" ]; then
        echo "SERVICE_HOST_NAME not set"
        sed -i -e "s/\${SERVICE_HOST_NAME}/$SERVICE_NAME/g" /usr/local/etc/haproxy/haproxy.cfg
    else
        echo "SERVICE_HOST_NAME is set"
        sed -i -e "s/\${SERVICE_HOST_NAME}/$SERVICE_HOST_NAME/g" /usr/local/etc/haproxy/haproxy.cfg
    fi

    start_rsyslogd
    start_lb "$@"
}

# make sure we have rsyslogd's pid file not
# created before
start_rsyslogd() {
  rm -f $RSYSLOG_PID
  rsyslogd
}

# Starts the load-balancer (haproxy) with
# whatever arguments we pass to it ("$@")
start_lb() {
  exec haproxy "$@"
}

main "$@"