#!/bin/bash
export PATH=$PATH:../required-files/bin
#export path of ca server home
export FABRIC_CA_CLIENT_HOME=../ca/crypto
export FABRIC_CA_SERVER_PATH=../ca-server
export FABRIC_CFG_PATH=$PWD/../configtx/

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../ca/crypto/Org2MSP/peers/peer0.khalil.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/../ca/crypto/Org2MSP/users/admin.khalil.com/msp
export CORE_PEER_ADDRESS=peer0.khalil.com:10051
export ORDERER_CA=../ca/crypto/orderers/orderer0.ibrahim.com/msp/tlscacerts/tlsca.orderer0.ibrahim.com-cert.pem

CHANNEL_NAME=$1
chaincodePath=../chaincodes/ChaincodeCommon
chaincodeName="chaincode_common"
version="1"
sequence="1"


peer channel fetch 0 -o orderer0.ibrahim.com:7050 -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
sleep 5
peer channel join -b ${CHANNEL_NAME}_0.block

sleep 2

peer channel list
peer channel getinfo -c $CHANNEL_NAME
