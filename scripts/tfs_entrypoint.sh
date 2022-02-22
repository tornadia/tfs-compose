#!/bin/bash
FILE=""
FROM_DIR="/otserv/forgottenserver/*"
TO_DIR="/otserv/local"

if [ -z "$(ls -A $TO_DIR)" ]; then
    cp -a $FROM_DIR $TO_DIR
fi
# rest of the logic