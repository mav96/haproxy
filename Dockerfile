FROM haproxy

RUN set -x	&& \
	apt-get update					&&  \
	apt-get install -y rsyslog  dnsutils iputils-ping &&  \
	mkdir -p /etc/rsyslog.d/				&&  \
	touch /var/log/haproxy.log				&&  \
	ln -sf /dev/stdout /var/log/haproxy.log

ADD haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
ADD errorfiles /usr/local/etc/haproxy/errorfiles
# Include our custom entrypoint that will the the job of lifting
# rsyslog alongside haproxy.
ADD entrypoint.sh /usr/local/bin/entrypoint
ADD rsyslog.d /etc/rsyslog.d
RUN chmod +x /usr/local/bin/entrypoint

# Set our custom entrypoint as the image's default entrypoint
ENTRYPOINT [ "entrypoint" ]

ARG SERVICE_NAME
ARG SERVICE_PORT
ARG SERVICE_COUNT
ARG SERVICE_MAXCONN
ARG SERVICE_HEALTH

# Make haproxy use the default configuration file
CMD [ "-f", "/usr/local/etc/haproxy/haproxy.cfg" ]