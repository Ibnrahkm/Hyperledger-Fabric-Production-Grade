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
CHAINCODE_PATH=$2
CH_NAME=$3
version=$4
LANG=$5

peer lifecycle chaincode package $CHAINCODE_NAME.tar.gz --path $CHAINCODE_PATH --lang $LANG --label $CHAINCODE_NAME
peer lifecycle chaincode install $CHAINCODE_NAME.tar.gz --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../ca/crypto/Org2MSP/peers/sample-corptwo.propvalchain.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/../ca/crypto/Org2MSP/users/admin.propvalchain.org2.com/msp
export CORE_PEER_ADDRESS=localhost:10051

peer lifecycle chaincode install $CHAINCODE_NAME.tar.gz --peerAddresses localhost:10051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE


peer lifecycle chaincode queryinstalled
echo "Enter package id:::"
read packid

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../ca/crypto/Org1MSP/peers/sample-corpone.propvalchain.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/../ca/crypto/Org1MSP/users/admin.propvalchain.org1.com/msp
export CORE_PEER_ADDRESS=localhost:9051

peer lifecycle chaincode approveformyorg -o localhost:7050 --tls --cafile $ORDERER_CA --channelID $CH_NAME --name $CHAINCODE_NAME  --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --version $version --package-id $packid --sequence $version  --signature-policy "OR ('Org1MSP.peer')"

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../ca/crypto/Org2MSP/peers/sample-corptwo.propvalchain.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/../ca/crypto/Org2MSP/users/admin.propvalchain.org2.com/msp
export CORE_PEER_ADDRESS=localhost:10051

peer lifecycle chaincode approveformyorg -o localhost:7050 --tls --cafile $ORDERER_CA --channelID $CH_NAME --name $CHAINCODE_NAME  --peerAddresses localhost:10051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --version $version --package-id $packid --sequence $version  --signature-policy "OR ('Org1MSP.peer')"

peer lifecycle chaincode checkcommitreadiness -o localhost:7050 --tls --cafile $ORDERER_CA --channelID $CH_NAME --name $CHAINCODE_NAME --version $version --sequence $version --signature-policy "OR ('Org1MSP.peer')"
peer lifecycle chaincode commit -o localhost:7050 --tls --cafile $ORDERER_CA --channelID $CH_NAME --name $CHAINCODE_NAME --version $version --sequence $version --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE  --peerAddresses localhost:10051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE  --signature-policy "OR ('Org1MSP.peer')"
