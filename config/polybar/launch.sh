#!/bin/sh

# killall -q polybar

polybar-msg cmd quit

echo "---" | tee -a /tmp/bar-main.log /tmp/bar-second.log
polybar main 2>&1 | tee -a /tmp/bar-main.log & disown
polybar secondary 2>&1 | tee -a /tmp/bar-second.log & disown

echo "Bars launched..."
