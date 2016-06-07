#!/bin/bash

#************************************************#
#                   hdspeedchk                   #
#           written by ....                      #
#                June 07, 2016                   #
#                                                #
#           Check speed of USB/SD/SSD etc.       #
#************************************************#

E_BADDEV=85                       # No such storage device

# --------------------------------------------------------- #
# perform_timing()                                          #
# Gets average read speed of all storage devices on pc      #
# Returns: 0 on success, $E_BADDEV if something went wrong. #
# --------------------------------------------------------- #

$ echo /dev/sd{a..h}
/dev/sda /dev/sdb /dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg /dev/sdh

if [ ! -d "$1" ]  # Test if target device exists.
  then
    echo "$1 is not a storage device."
    return $E_BADDEV
  fi

perform_timing() {
    for i in {1..6}; do hdparm -t "$1"; done |
        awk '/seconds/ { total += $11; count++ } END { print (total / count) }'
        return 0   # Success.
}

for drive in /dev/sd{a..h}; do
    printf '%s: %s\n' "$drive" "$(perform_timing "$drive")"
done

return 0   # Success.

exit $?
