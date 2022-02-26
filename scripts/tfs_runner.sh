#!/bin/bash

cd /otserv/local/build && make -j$(nproc) && mv tfs .. || exit
chmod +x /otserv/local/tfs
cd /otserv/local && ./tfs