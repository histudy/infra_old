#!/bin/sh -eux

set +e
swapuuid="`/sbin/blkid -o value -l -s UUID -t TYPE=swap`";
case "$?" in
    2|0) ;;
    *) exit 1 ;;
esac
set -e

if [ "x${swapuuid}" != "x" ]; then
    swappart="`readlink -f /dev/disk/by-uuid/$swapuuid`";
    /sbin/swapoff "$swappart";
    dd if=/dev/zero of="$swappart" bs=1M || echo "dd exit code $? is suppressed";
    /sbin/mkswap -U "$swapuuid" "$swappart";
fi

touch /tmp/empty;
dd if=/dev/zero of=/tmp/empty bs=1M || echo "dd exit code $? is suppressed";
rm -f /tmp/empty;
sync;
