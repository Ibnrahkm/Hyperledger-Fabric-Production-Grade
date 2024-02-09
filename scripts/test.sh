#!/bin/bash

./runCA.sh ca-system admin adminpw ../yamls/ca.yaml

./registerOrderer.sh ca-system orderer$1 orderer$1pw 

./enrollOrderer.sh ca-system orderer$1 orderer$1pw orderer$1.system.com

./registerPeer.sh ca-system peer$1 peer$1pw 

./enrollPeer.sh ca-system peer$1 peer$1pw org$1 peer$1.org$1.com

./registerAdmin.sh ca-system admin$1 adminpw 

./enrollAdmin.sh ca-system admin$1 adminpw org$1 peer$1.org$1.com admin$1.org$1.com

./registerUser.sh ca-system user$1 user$1pw 

./enrollUser.sh ca-system user$1 user$1pw org$1 peer$1.org$1.com user$1.org$1.com
