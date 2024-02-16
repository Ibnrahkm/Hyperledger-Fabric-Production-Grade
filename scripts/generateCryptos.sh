#!/bin/bash

./registerOrderer.sh caibrahim orderer0.ibrahim.com adminpw 

./enrollOrderer.sh caibrahim orderer0.ibrahim.com adminpw orderer0.ibrahim.com

./registerPeer.sh caibrahim peer0.ibrahim.com adminpw

./enrollPeer.sh caibrahim peer0.ibrahim.com adminpw Org1MSP peer0.ibrahim.com

./registerPeer.sh caibrahim peer0.khalil.com adminpw

./enrollPeer.sh caibrahim peer0.khalil.com adminpw Org2MSP peer0.khalil.com

./registerAdmin.sh caibrahim admin.ibrahim.com adminpw 

./enrollAdmin.sh caibrahim admin.ibrahim.com adminpw Org1MSP admin.ibrahim.com

./registerAdmin.sh caibrahim admin.khalil.com adminpw 

./enrollAdmin.sh caibrahim admin.khalil.com adminpw Org2MSP admin.khalil.com

./registerUser.sh caibrahim user.ibrahim.com userpw 

./enrollUser.sh caibrahim user.ibrahim.com userpw Org1MSP user.ibrahim.com


./registerUser.sh caibrahim user.khalil.com userpw 

./enrollUser.sh caibrahim user.khalil.com userpw Org2MSP user.khalil.com

echo "cryptos for blockchain generated"
