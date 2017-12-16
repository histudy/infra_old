#!/bin/sh -eux

arch="`uname -r | sed 's/^.*[0-9]\{1,\}\.[0-9]\{1,\}\.[0-9]\{1,\}\(-[0-9]\{1,2\}\)-//'`"

apt-get update;

apt-get -y upgrade linux-image-$arch;
apt-get -y install linux-headers-`uname -r`;

if [ -d /etc/init ]; then
    # update package index on boot
    cat <<EOF >/etc/init/refresh-apt.conf;
description "update package index"
start on networking
task
exec /usr/bin/apt-get update
EOF
fi


SSHD_CONFIG="/etc/ssh/sshd_config";

# ensure that there is a trailing newline before attempting to concatenate
sed -i -e '$a\' "$SSHD_CONFIG";

USEDNS="UseDNS no"
if grep -q -E "^[[:space:]]*UseDNS" "$SSHD_CONFIG"; then
    sed -i "s/^\s*UseDNS.*/${USEDNS}/" "$SSHD_CONFIG"
else
    echo "$USEDNS" >>"$SSHD_CONFIG"
fi

GSSAPI="GSSAPIAuthentication no"
if grep -q -E "^[[:space:]]*GSSAPIAuthentication" "$SSHD_CONFIG"; then
    sed -i "s/^\s*GSSAPIAuthentication.*/${GSSAPI}/" "$SSHD_CONFIG"
else
    echo "$GSSAPI" >>"$SSHD_CONFIG"
fi

# Only add the secure path line if it is not already present - Debian 7
# includes it by default.
grep -q 'secure_path' /etc/sudoers \
  || sed -i -e '/Defaults\s\+env_reset/a Defaults\tsecure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"' /etc/sudoers;

# Adding a 2 sec delay to the interface up, to make the dhclient happy
echo "pre-up sleep 2" >> /etc/network/interfaces;

# Set up password-less sudo for the vagrant user
echo 'vagrant ALL=(ALL) NOPASSWD:ALL' >/etc/sudoers.d/vagrant;
chmod 440 /etc/sudoers.d/vagrant;
