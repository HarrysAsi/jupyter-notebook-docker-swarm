#!/bin/bash

echo "Script which installs the gluster fs shared volume on a server!"

read -p "Give me your domain:" domain
read -s -p "Password:" pwd


sshpass -p $pwd ssh $domain 'bash -s' < install-gluster-worker-commands.sh $pwd

