#!/bin/bash
# just to save some keystrokes
	# zpool requirements: lz4_enabled large_blocks and SET ASHIFT!
#set -e
# demand root
sudo echo "CREATING ZFS FILESYSTEM FOR OMERO" || (echo "must be run as root" && exit 1)

# demand zpool
[[ -z $1 ]] && echo "give zpool name pls" && exit 1

# delete old dataset if it exists
[[ -e /$1/omeroZFS ]] && zfs destroy -r $1/omeroZFS && echo "destroyed old dataset"

# create dataset, set common configs
	# with hard disks, compression is a nobrainer
	# relatime for webapps
	# with files this large and psql, caching causes more harm than good (?)
		# i'll only keep enabled for a good .1 sec latency reduction
	# log bias? we don't have l2arc so idk if that even matters, maybe carve a section out of boot?
zfs create -o xattr=sa -o compression=lz4 -o atime=off -o relatime=on -o primarycache=metadata $1/omeroZFS
echo "created parent dataset"
#give the permissions to omero-server

# create set for ome.tiffs ##I REALLY want to try multi MB recordsizes
zfs create -o recordsize=1M -o primarycache=all -o relatime=off $1/omeroZFS/omeTIFF
echo "created ometiff dir"

# create set for logs
zfs create -o compression=gzip-1 -o primarycache=none $1/omeroZFS/logs
echo "created master log dir"
mkdir /$1/omeroZFS/logs/server && chown -R 1000:997 /$1/omeroZFS/logs/server
echo "made log dir for omero.server"
mkdir /$1/omeroZFS/logs/postgres && chown -R 70:70 /$1/omeroZFS/logs/postgres
echo "made log dir for postgres"

# create set for omero server data
	#no idea on whats best here
zfs create -o recordsize=8k $1/omeroZFS/server
echo "created server dir"
chown -R 1000:997 /$1/omeroZFS/server

# create sets for psql
	# mostly changes in psql itself
zfs create -o primarycache=none -o recordsize=8k $1/omeroZFS/postgre
zfs create $1/omeroZFS/postgre/data
zfs create $1/omeroZFS/postgre/wal
chown -R 70:70 /$1/omeroZFS/postgre
echo "created postgre dirs"
echo "finished!"
