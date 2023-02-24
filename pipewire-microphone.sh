#!/bin/sh

status() {
	echo $(wpctl status | grep Sources -A2 | grep vol | sed s/[' '\]/\\n/g | tail -n1 | tr -d ] | cut -d. -f2)%
}

listen() {
	status

	LANG=EN
	pactl subscribe | while read -r event; do
		if echo "$event" | grep -q "source" || echo "$event" | grep -q "server"; then
			status
		fi
	done
}

toggle() {
	wpctl set-mute $(wpctl status | grep Sources -A2 | grep vol | cut -d. -f1 | tr -d [\│\*\ ]) toggle
}

increase() {
	wpctl set-volume $(wpctl status | grep Sources -A2 | grep vol | cut -d. -f1 | tr -d [\│\*\ ]) 1%+
}

decrease() {
	wpctl set-volume $(wpctl status | grep Sources -A2 | grep vol | cut -d. -f1 | tr -d [\│\*\ ]) 1%-
}

case "$1" in
--toggle)
	toggle
	;;
--increase)
	increase
	;;
--decrease)
	decrease
	;;
*)
	listen
	;;
esac
