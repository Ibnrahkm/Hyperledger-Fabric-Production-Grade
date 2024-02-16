#!/bin/bash
export PATH=$PATH:../required-files/bin
#export path of ca server home
export FABRIC_CA_CLIENT_HOME=../ca/crypto
export FABRIC_CA_SERVER_PATH=../ca-server
export FABRIC_CFG_PATH=$PWD/../configtx/

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../ca/crypto/Org1MSP/peers/peer0.ibrahim.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/../ca/crypto/Org1MSP/users/admin.ibrahim.com/msp
export CORE_PEER_ADDRESS=peer0.ibrahim.com:9051
export ORDERER_CA=../ca/crypto/orderers/orderer0.ibrahim.com/msp/tlscacerts/tlsca.orderer0.ibrahim.com-cert.pem

CHANNEL_NAME=$1
chaincodePath=../chaincodes/ChaincodeCommon
chaincodeName="chaincode_common"
version="1"
sequence="1"


configtxgen -profile TwoOrgsApplicationGenesis -outputCreateChannelTx ../channel-artifacts/$CHANNEL_NAME.tx -channelID $CHANNEL_NAME

sleep 5

peer channel create -o orderer0.ibrahim.com:7050 -c $CHANNEL_NAME -f ../channel-artifacts/$CHANNEL_NAME.tx --outputBlock ../channel-artifacts/$CHANNEL_NAME.block --tls --cafile $ORDERER_CA

sleep 5

peer channel join -b ../channel-artifacts/$CHANNEL_NAME.block

sleep 2

peer channel list
peer channel getinfo -c $CHANNEL_NAME
echo "done!"
