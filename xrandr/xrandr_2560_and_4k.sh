#!/bin/sh
xrandr --verbose --fb 4720x3840 \
	--output DP-0 --off \
	--output DP-1 --off \
	--output HDMI-0 --off \
	--output DP-2 --primary --mode 2560x1440 --pos 0x920 --panning 2560x1440+0+920 --rotate normal \
	--output DP-3 --off \
	--output DP-4 --mode 3840x2160 --pos 2560x0 --rotate left \
	--output DP-5 --off
