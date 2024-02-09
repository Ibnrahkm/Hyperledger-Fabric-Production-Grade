#!/bin/bash

 docker rm -f $(docker ps -a | grep fabric | awk '{print $1}')
sudo rm -rf ../ca/crypto ../ca/ca-server ../volumes
 echo "network down successfully"



