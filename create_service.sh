#!/bin/sh
##
# Script to deamons as a service.
##

# Check for deamon argument
if [[ $# -eq 0 ]] ; then
    echo 'You must provide the DEAmon argument'
    echo '  Usage:  ./create_service.sh polisd polis-cli .poliscore polis.conf'
    echo
    exit 1
fi
echo "Creating It ALL!!!"

sudo touch /etc/systemd/system/mn.service
echo '[Unit]
Description='${1}'
After=network.target
[Service]
Type=simple
User=root
WorkingDirectory=/root
ExecStart=/usr/local/bin/'${1}' -conf=/root/'${3}'/'${4}' -datadir=/root/'${3}'
ExecStop=/usr/local/bin/'${2}' -conf=/root/'${3}'/'${4}' -datadir=/root/'${3}' stop
Restart=on-abort
[Install]
WantedBy=multi-user.target
' | sudo -E tee /etc/systemd/system/mn.service
sudo systemctl enable mn
sudo systemctl start mn


echo "You are done!"
echo
