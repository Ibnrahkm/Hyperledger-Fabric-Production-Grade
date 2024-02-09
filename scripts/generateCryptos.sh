#!/bin/bash

./registerOrderer.sh capropvalchain sample-orderer.propvalchain.com adminpw 

./enrollOrderer.sh capropvalchain sample-orderer.propvalchain.com adminpw sample-orderer.propvalchain.com

./registerPeer.sh capropvalchain sample-corpone.propvalchain.com adminpw

./enrollPeer.sh capropvalchain sample-corpone.propvalchain.com adminpw Org1MSP sample-corpone.propvalchain.com

./registerPeer.sh capropvalchain sample-corptwo.propvalchain.com adminpw

./enrollPeer.sh capropvalchain sample-corptwo.propvalchain.com adminpw Org2MSP sample-corptwo.propvalchain.com

./registerAdmin.sh capropvalchain admin.propvalchain.org1.com adminpw 

./enrollAdmin.sh capropvalchain admin.propvalchain.org1.com adminpw Org1MSP admin.propvalchain.org1.com

./registerAdmin.sh capropvalchain admin.propvalchain.org2.com adminpw 

./enrollAdmin.sh capropvalchain admin.propvalchain.org2.com adminpw Org2MSP admin.propvalchain.org2.com

./registerUser.sh capropvalchain user.propvalchain.org1.com userpw 

./enrollUser.sh capropvalchain user.propvalchain.org1.com userpw Org1MSP user.propvalchain.org1.com


./registerUser.sh capropvalchain user.propvalchain.org2.com userpw 

./enrollUser.sh capropvalchain user.propvalchain.org2.com userpw Org2MSP user.propvalchain.org2.com

echo "cryptos for blockchain generated"
