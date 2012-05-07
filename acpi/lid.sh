state_open=`grep open /proc/acpi/button/lid/LID/state`
state_close=`grep closed /proc/acpi/button/lid/LID/state`

if [ -n "$state_open" ]; then
    echo "Running xrandr on $(date) to turn on internal screen" >> /home/alsz/lid.log
    DISPLAY=:0.0 su alsz -c "xrandr --output HDMI2 --off" &>> /home/alsz/lid.log
    sleep 5
    echo "Running second command" >> /home/alsz/lid.log
    DISPLAY=:0.0 su alsz -c "xrandr --output eDP1 --mode 1280x800 --primary --output HDMI1 --right-of eDP1" &>> /home/alsz/lid.log
    echo "Lid open on $(date). Additional data: $1" >> /home/alsz/lid.log
    exit 0
fi

if [ -n "$state_close" ]; then
    echo "Running xrandr on $(date) to turn on HDMI1 and HDMI2" >> /home/alsz/lid.log
    DISPLAY=:0.0 su alsz -c "xrandr --output eDP1 --off" &>> /home/alsz/lid.log
    sleep 5
    echo "Running second command" >> /home/alsz/lid.log
    DISPLAY=:0.0 su alsz -c "xrandr --output HDMI1 --mode 1680x1050 --primary --output HDMI2 --mode 1280x1024 --right-of HDMI1" &>> /home/alsz/lid.log
    echo "Lid closed on $(date). Additional data: $1" >> /home/alsz/lid.log
    exit 0
fi

echo "Unknown state of lid:  $(`cat /proc/acpi/button/lid/LID/state`). Additional data: $1" >> /home/alsz/lid.log

