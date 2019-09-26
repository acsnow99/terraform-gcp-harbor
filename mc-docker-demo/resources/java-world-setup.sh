#!/bin/bash

rm -r ~/minecraft/${worldname} || true
mkdir ~/minecraft/${worldname} || true
cp -r /tmp/db/* ~/minecraft/${worldname} || true
chmod -R 777 ~/minecraft/${worldname} || true
# sets up FTB directory as well just in case
rm -r ~/minecraft/FeedTheBeast/${worldname} || true
mkdir ~/minecraft/FeedTheBeast || true
mkdir ~/minecraft/FeedTheBeast/${worldname} || true
cp -r /tmp/db/* ~/minecraft/FeedTheBeast/${worldname} || true
chmod -R 777 ~/minecraft/FeedTheBeast || true

sudo docker stop mc
sudo docker start mc