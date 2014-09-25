#!/bin/bash

set -e

# add repositories
zypper --non-interactive ar -f http://download.opensuse.org/distribution/13.1/repo/oss/suse/ opensuse-13.1-oss
zypper --non-interactive ar -f http://download.opensuse.org/update/13.1/openSUSE:13.1:Update.repo
zypper -v --gpg-auto-import-keys --no-gpg-checks -n ref

# get testscript
wget https://raw.githubusercontent.com/SUSE-Cloud/automation/master/scripts/qa_devstack.sh

bash -x qa_devstack.sh

exit 0
