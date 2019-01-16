FROM "mireiawen/borg-client"

MAINTAINER "Mira Liikanen <mir@mireiawen.net>"

ENV BORG_REPO="/mnt/repo.borg"
ENV BORG_PASSPHRASE="really_secret"
ENV BORG_SOURCES="/home /var"
ENV BORG_KEEP="14 5 6"
ENV CRON="0 3 * * *"

RUN \
	install_packages \
		"cron" \
		"syslog-ng-core" \
		"syslog-ng-mod-journal"

COPY "start.sh" "/start.sh"
COPY "job.sh" "/job.sh"
COPY "syslog-ng.conf" "/etc/syslog-ng/syslog-ng.conf"

ENTRYPOINT [ "/bin/bash" ]
CMD [ "/start.sh" ]
