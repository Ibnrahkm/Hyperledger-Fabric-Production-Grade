#!/bin/bash
export PATH=$PATH:../required-files/bin
#export path of ca server home
export FABRIC_CA_CLIENT_HOME=../ca/crypto
export FABRIC_CA_SERVER_PATH=../ca-server
export FABRIC_CFG_PATH=$PWD/../configtx/

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../ca/crypto/Org1MSP/peers/sample-corpone.propvalchain.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/../ca/crypto/Org1MSP/users/admin.propvalchain.org1.com/msp
export CORE_PEER_ADDRESS=localhost:9051
export ORDERER_CA=../ca/crypto/orderers/sample-orderer.propvalchain.com/msp/tlscacerts/tlsca.sample-orderer.propvalchain.com-cert.pem

CHAINCODE_NAME=$1
CH_NAME=$2

peer chaincode invoke -o localhost:7050 --tls --cafile $ORDERER_CA  -C $CH_NAME -n $CHAINCODE_NAME --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE -c '{"function":"initLedger","Args":[]}'


