#!/bin/bash

set -euxo pipefail

exec /usr/sbin/squid --foreground ${SQUID_OPTIONS:-}
