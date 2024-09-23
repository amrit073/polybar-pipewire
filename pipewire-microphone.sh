#!/bin/sh

status() {
	res=$(wpctl status | grep Sources -A2 | grep vol | cut -d: -f2 | tr -d ] | cut -c2- | sed 's/^0//' | tr -d .)
	if echo "$res" | grep -q MUTED; then
		echo muted
	else
		echo "$res"%
	fi
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

zerodb() {
	wpctl set-volume $(wpctl status | grep Sources -A2 | grep vol | cut -d. -f1 | tr -d [\│\*\ ]) 100%
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
--zerodb)
	zerodb
	;;
*)
	status
	;;
esac
