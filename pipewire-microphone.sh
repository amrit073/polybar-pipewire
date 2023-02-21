#!/bin/sh

 status() {
   MUTED=$(pactl list sources  | grep Mute | tail -n1 | cut -d: -f2   | tr -d ' ')

  if [ "$MUTED" = "yes" ]; then
     echo "muted"
   else
     pactl list sources | grep Volume | tail -n2 | head -n1 |  cut -d'/' -f2 | tr -d ' ' 
   fi
 }

 listen() {
     status

     LANG=EN; pactl subscribe | while read -r event; do
         if echo "$event" | grep -q "source" || echo "$event" | grep -q "server"; then
             status
         fi
     done
 }

 toggle() {
   MUTED=$(pactl list sources  | grep Mute | tail -n1 | cut -d: -f2   | tr -d ' ')
  DEFAULT_SOURCE=$(pactl list sources  | grep Name | tail -n1 | cut -d':' -f2 | tr -d ' ')

   if [ "$MUTED" = "yes" ]; then
       pactl set-source-mute "$DEFAULT_SOURCE" 0
   else
       pactl set-source-mute "$DEFAULT_SOURCE" 1
   fi
 }

 increase() {
   DEFAULT_SOURCE=$(pactl list sources  | grep Name | tail -n1 | cut -d':' -f2 | tr -d ' ')
   pactl set-source-volume "$DEFAULT_SOURCE" +5%
 }

 decrease() {
   DEFAULT_SOURCE=$(pactl list sources  | grep Name | tail -n1 | cut -d':' -f2 | tr -d ' ')
   pactl set-source-volume "$DEFAULT_SOURCE" -5%
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

