
#!/bin/bash

### for org 2



#export path of ca server home
export FABRIC_CA_CLIENT_HOME=../ca/crypto
export FABRIC_CA_SERVER_PATH=../ca-server
export FABRIC_CFG_PATH=$PWD/../configtx/
export PATH=$PATH:../required-files/bin
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../ca/crypto/Org2MSP/peers/peer0.khalil.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/../ca/crypto/Org2MSP/users/admin.khalil.com/msp
export CORE_PEER_ADDRESS=peer0.khalil.com:10051
export ORDERER_CA=../ca/crypto/orderers/orderer0.ibrahim.com/msp/tlscacerts/tlsca.orderer0.ibrahim.com-cert.pem
CHANNEL_NAME=$1

peer channel fetch config config_block.pb -o orderer0.ibrahim.com:7050 -c $CHANNEL_NAME --tls --cafile $ORDERER_CA


######## if jq not installed########
#sudo apt install jq
#source ~/.profile
#close and open terminal
######################################

configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json
jq '.data.data[0].payload.data.config' config_block.json > config.json

cp config.json config_copy.json





jq '.channel_group.groups.Application.groups.Org2MSP.values += {"AnchorPeers":{"mod_policy": "Admins","value":{"anchor_peers": [{"host": "peer0.khalil.com","port": 10051}]},"version": "0"}}' config_copy.json > modified_config.json


configtxlator proto_encode --input config.json --type common.Config --output config.pb
configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb
configtxlator compute_update --channel_id $CHANNEL_NAME --original config.pb --updated modified_config.pb --output config_update.pb



configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate --output config_update.json
echo '{"payload":{"header":{"channel_header":{"channel_id":"'${CHANNEL_NAME}'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . > config_update_in_envelope.json
configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope --output config_update_in_envelope.pb

peer channel update -f config_update_in_envelope.pb -c $CHANNEL_NAME -o orderer0.ibrahim.com:7050 --tls --cafile $ORDERER_CA
