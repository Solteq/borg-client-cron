#!/bin/bash
set -e

if [ ! -f "/.env" ]
then
	# Write the environment
	cat <<- EOF >"/.env"
	BORG_REPO="${BORG_REPO}"
	BORG_PASSPHRASE="${BORG_PASSPHRASE}"
	BORG_SOURCES="${BORG_SOURCES}"
	BORG_KEEP="${BORG_KEEP}"
	EOF
	
	# Create the cron row
	( /usr/bin/crontab -l ||/bin/true 2>'/dev/null' \
		; /bin/echo -e "\n# Backup job\n${CRON} /bin/bash '/job.sh'") | /usr/bin/crontab -
	
	# Initialize the repository
	borg 'init' \
		--encryption 'keyfile'
fi

/usr/sbin/cron -f -L 7
