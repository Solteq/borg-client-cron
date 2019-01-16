#!/bin/bash
set -e

# Load the environment
[ -f "/.env" ] && source "/.env"

BORG_DAILY="$(echo "${BORG_KEEP}" |cut --delim=' ' --fields='1')"
BORG_WEEKLY="$(echo "${BORG_KEEP}" |cut --delim=' ' --fields='2')"
BORG_MONTHLY="$(echo "${BORG_KEEP}" |cut --delim=' ' --fields='3')"
export BORG_PASSPHRASE
export BORG_REPO

borg 'create' "${BORG_REPO}::$(date '+%Y-%m-%d_%H.%I')" \
	${BORG_SOURCES} \
	--exclude-if-present '.nobackup'

borg 'prune' \
        --keep-daily="${BORG_DAILY}" \
        --keep-weekly="${BORG_WEEKLY}" \
        --keep-monthly="${BORG_MONTHLY}"

