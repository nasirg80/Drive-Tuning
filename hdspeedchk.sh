#!/bin/bash

#************************************************#
#                   hdspeedchk                   #
#           written by ....                      #
#                June 07, 2016                   #
#                                                #
#           Check speed of USB/SD/SSD etc.       #
#************************************************#

E_BADDIR=85                       # No such directory.
projectdir=/home/bozo/projects    # Directory to clean up.

# --------------------------------------------------------- #
# cleanup_pfiles ()                                         #
# Removes all files in designated directory.                #
# Parameter: $target_directory                              #
# Returns: 0 on success, $E_BADDIR if something went wrong. #
# --------------------------------------------------------- #

$ echo /dev/sd{a..h}
/dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh

perform_timing() {
    for i in {1..6}; do hdparm -t "$1"; done |
        awk '/seconds/ { total += $11; count++ } END { print (total / count) }'
}

for drive in /dev/sd{a..h}; do
    printf '%s: %s\n' "$drive" "$(perform_timing "$drive")"
done
