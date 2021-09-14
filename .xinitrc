[ -r $HOME/.profile ] && . $HOME/.profile

for file in /etc/X11/xinit/xinitrc.d/*; do
  .  $file
done

export DefaultIMModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

export $(dbus-launch)
fcitx-autostart &
xrdb ~/.Xresources
#setxkbmap -layout us -variant dvorak
xset r rate 200 30

exec xmonad
