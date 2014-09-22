#!/bin/bash

set -e

# add repositories
zypper --non-interactive ar -f http://download.opensuse.org/repositories/Cloud:/OpenStack:/Master/openSUSE_13.1/Cloud:OpenStack:Master.repo
zypper --non-interactive ar -f http://download.opensuse.org/distribution/13.1/repo/oss/suse/ opensuse-13.1-oss
zypper --non-interactive ar -f http://download.opensuse.org/update/13.1/openSUSE:13.1:Update.repo
zypper -v --gpg-auto-import-keys --no-gpg-checks -n ref
zypper --non-interactive in patch

# screenrc
cat > ~/.screenrc <<EOF
altscreen on
defscrollback 20000
startup_message off
hardstatus alwayslastline
hardstatus string '%H (%S%?;%u%?) %-Lw%{= BW}%50>%n%f* %t%{-}%+Lw%<'
EOF

# clone devstack (version with some patches for opensuse)
#git clone https://github.com/openstack-dev/devstack.git
git clone -b devstack-opensuse131 https://github.com/toabctl/devstack.git

# setup devstack configuration
cat > devstack/local.conf <<EOF
[[local|localrc]]
SERVICE_TOKEN=testtoken
DATABASE_PASSWORD=test
ADMIN_PASSWORD=test
RABBIT_PASSWORD=test
SERVICE_PASSWORD=test

RECLONE=yes
HOST_IP=127.0.0.1
LOGFILE=stack.sh.log
LOGDAYS=1
SCREEN_LOGDIR=/opt/stack/logs
LOG_COLOR=False
API_RATE_LIMIT=False
TEMPEST_ALLOW_TENANT_ISOLATION=True

# use postgres instead of mysql as database
disable_service mysql
enable_service postgresql

# swift is disabled by default
##enable_service s-proxy s-object s-container s-account

# Use Neutron instead of Nova network
disable_service n-net
enable_service q-svc
enable_service q-agt
enable_service q-dhcp
enable_service q-l3
enable_service q-meta
enable_service q-metering

# for testing
enable_service tempest
EOF

chown vagrant:vagrant -R devstack

exit 0
