#!/bin/bash

opened=0
 
echo "Waiting MariaDB to launch on 3306..."
while ! nc -z 172.66.0.11 3306; do   
  sleep 0.1 # wait for 1/10 of the second before check again
done
 
echo "MariaDB launched, running TFS"
./tfs