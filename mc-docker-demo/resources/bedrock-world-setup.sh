#!/bin/bash

rm -r ~/minecraft/worlds/${worldname} || true
mkdir ~/minecraft/worlds/${worldname} || true
cp -r /tmp/db ~/minecraft/worlds/${worldname}/db || true
chmod -R 777 ~/minecraft/worlds/${worldname}/db || true

sudo docker stop mc
sudo docker start mc