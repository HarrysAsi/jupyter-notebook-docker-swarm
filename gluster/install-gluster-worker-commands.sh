pwd=$1
echo $pwd
sudo apt-get install software-properties-common -y
sudo add-apt-repository ppa:gluster/glusterfs-7
sudo apt-get update -y
sudo apt-get install glusterfs-server -y
sudo systemctl start glusterd
sudo systemctl enable glusterd
echo $pwd | sudo -S mkdir -p /gluster/volume1
echo $pwd | sudo -S echo 'localhost:/staging-gfs /mnt glusterfs defaults,_netdev,backupvolfile-server=localhost 0 0' >> /etc/fstab
echo $pwd | sudo -S mount.glusterfs localhost:/staging-gfs /mnt
echo $pwd | sudo -S chown -R root:docker /mnt
