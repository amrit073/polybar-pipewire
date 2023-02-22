Polybar defaut module for audio output works with pipewire so there is not need to change that.
What it looks like:
![image](https://i.imgur.com/MZhb0a7.png)
For controlling microphone:
```
git clone <this url>
cd polybar-pipewire-microphone
mv pipewire-microphone.sh $HOME/.config/polybar/scripts/pipewire-microphone.sh
```

Add following lines in you polybar's config.ini file

```ini
[module/pipewire-microphone]
type = custom/script
format = <label>
format-prefix = " "
format-prefix-foreground = ${colors.primary}
label = %output%
label-muted = 
exec = $HOME/.config/polybar/scripts/pipewire-microphone.sh
tail = true
click-left = $HOME/.config/polybar/scripts/pipewire-microphone.sh --toggle &
scroll-up = $HOME/.config/polybar/scripts/pipewire-microphone.sh --increase &
scroll-down = $HOME/.config/polybar/scripts/pipewire-microphone.sh --decrease &

[module/pulseaudio]
type = internal/pulseaudio

format-volume-prefix = " "
format-volume-prefix-foreground = ${colors.primary}
format-volume = <label-volume>

label-volume = %percentage%%

label-muted = muted
label-muted-foreground = ${colors.disabled}
```
Add to you list of modules as:
```
modules-right  =   pulseaudio pipewire-microphone memory cpu date powermenu
```

<br>
you might want to change the icons according to font your polybar is currently using
Thanks!
