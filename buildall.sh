#!/bin/sh

for i in hadoop namenode datanode resourcemanager nodemanager spark; do
    echo Building $i
    ( cd $i && ./build.sh)
done
