#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.5; done

# Launch Polybar, using default config location ~/.config/polybar/config
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log
/usr/bin/polybar -r -c ~/.config/polybar/config_bspwm left >>/tmp/polybar1.log 2>&1 &
/usr/bin/polybar -r -c ~/.config/polybar/config_bspwm center >>/tmp/polybar2.log 2>&1 &
/usr/bin/polybar -r -c ~/.config/polybar/config_bspwm right >>/tmp/polybar3.log 2>&1 &

echo "Polybar launched..."
