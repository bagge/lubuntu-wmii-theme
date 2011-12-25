#!/bin/bash

where_am_i=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

function maybe_create {
    if [ -e $2 ]; then
        echo "$2 already exists."
    else
        ln -s $1 $2
    fi
}

function maybe_delete {
    if [ -h $1 ]; then
        rm $1
    else
        echo "$1 not found"
    fi
}

function install_links {
    maybe_create $where_am_i/handicap_menu.png \
        /usr/share/lubuntu/images/handicap_menu.png
    maybe_create $where_am_i/lxpanel_wmii /usr/share/lxpanel/profile/wmii
    maybe_create $where_am_i/lxsession_wmii /etc/xdg/lxsession/wmii
    maybe_create $where_am_i/startwmii /usr/bin/startwmii
    maybe_create $where_am_i/wmii-lxpanel.desktop \
        /usr/share/xsessions/wmii-lxpanel.desktop
    maybe_create $where_am_i/acpi/lid_event /etc/acpi/events/lid
    maybe_create $where_am_i/acpi/lid.sh /etc/acpi/lid.sh
}

function uninstall_links {
    maybe_delete /usr/share/lubuntu/images/handicap_menu.png
    maybe_delete /usr/share/lxpanel/profile/wmii
    maybe_delete /etc/xdg/lxsession/wmii
    maybe_delete /usr/bin/startwmii
    maybe_delete /usr/share/xsessions/wmii-lxpanel.desktop
    maybe_delete /etc/acpi/events/lid
    maybe_delete /etc/acpi/lid.sh
}

function usage {
    echo "$0 [ packages | install | uninstall ]"
    echo ""
    echo "   packages: will install the needed external packages"
    echo "   install: Will create the necessary symlinks to install"
    echo "   uninstall: Will uninstall by removing the symlinks"
}

if [ -z "$1" ]; then
    usage
    exit 0
fi

if [ "$1" == "packages" ]; then
    apt-get install wmii acpi acpid
    exit 0
fi

if [ "$1" == "install" ]; then
    install_links
    exit 0
fi

if [ "$1" == "uninstall" ]; then
    uninstall_links
    exit 0
fi

echo "Unrecognized parameter: $1"
usage
exit 1

