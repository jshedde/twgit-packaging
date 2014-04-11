#!/bin/bash

if [ ! -f /usr/local/bin/twgit ]; then
    rm -rf /usr/local/bin/twgit
fi
cd /usr/local/share/twgit
echo -e "Y\nY\nY\nY" | make install
