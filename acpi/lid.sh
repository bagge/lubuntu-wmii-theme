state_open=`grep open /proc/acpi/button/lid/LID/state`
state_close=`grep closed /proc/acpi/button/lid/LID/state`

if [ -n "$state_open" ]; then
    echo "Lid open on $(date). Additional data: $1" >> /home/alsz/lid.log
    exit 0
fi

if [ -n "$state_close" ]; then
    echo "Lid closed on $(date). Additional data: $1" >> /home/alsz/lid.log
    exit 0
fi

echo "Unknown state of lid:  $(`cat /proc/acpi/button/lid/LID/state`). Additional data: $1" >> /home/alsz/lid.log

