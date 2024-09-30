#!/usr/bin/env bash

check() {
	command -v "$1" 1>/dev/null
}
catcmd="/usr/bin/cat"
system-battery() {
	mapfile -t batteries < <(/usr/bin/ls -d "/sys/class/power_supply/BAT"*)
	for i in "${batteries[@]}"; do
		echo "$(basename "$i"): $($catcmd "$i"/model_name) $($catcmd "$i"/technology)"
		echo "  Status:       $($catcmd "$i"/status)"
		echo "  Health:       $(($($catcmd "$i"/*_full) * 100 / $($catcmd "$i"/*_full_design)))%"
    if [ -f "$i/power_now" ];then
		  echo "  Power Draw:   $(($($catcmd "$i"/power_now) / 1000000)) "
    fi
		echo "  Cycle:        $($catcmd "$i"/cycle_count)"
		echo "  Capacity:     $($catcmd "$i"/capacity)%"
    if [ -f "$i/charge_control_end_threshold" ];then
      echo "  Charge Limit: $($catcmd "$i"/charge_control_end_threshold)%"
    fi
	done
	echo ""
}

otherdevice() {
	check kdeconnect-cli || return
	check qdbus || return

	mdata="$(kdeconnect-cli -a 2>/dev/null)" # meta data returned from kdeconnect-cli

	[ -z "$mdata" ] && return # return if no meta data is available

	id="$(echo "${mdata#*:}" | awk '{print $1}')"
	devicename="$(echo "$mdata" | awk '{print $2}')"

	battery="$(
		qdbus \
			org.kde.kdeconnect.daemon \
			/modules/kdeconnect/devices/"$id"/battery \
			org.kde.kdeconnect.device.battery.charge
	)"

	state="$(
		qdbus \
			org.kde.kdeconnect.daemon \
			/modules/kdeconnect/devices/"$id"/battery \
			org.kde.kdeconnect.device.battery.isCharging
	)" # returns boolean based on chrarging state

	$state && state="Charging" || state="Not Charging"

	echo "$devicename:"
	echo "  Status:     $state"
	echo "  Capacity:   $battery%"
	echo ""
}
main() {
	system-battery
	otherdevice
}

main
