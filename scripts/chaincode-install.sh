

# org1

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/ca/crypto/Org1MSP/peers/peer0.ibrahim.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/ca/crypto/Org1MSP/users/admin.ibrahim.com/msp
export CORE_PEER_ADDRESS=peer0.ibrahim.com:9051
export TLS_ROOT_CA=${PWD}/ca/crypto/orderers/orderer0.ibrahim.com/tls/ca.crt
export PATH=${PWD}/../required-files/bin:$PATH
export FABRIC_CFG_PATH=${PWD}/../configtx
export CHAINCODE_NAME=basic
export CHAINCODE_PATH=${PWD}/chaincode/javascript
export ORDERER_ENDPOINT=orderer0.ibrahim.com:7050

peer lifecycle chaincode package $CHAINCODE_NAME.tar.gz --path $CHAINCODE_PATH --lang node --label $CHAINCODE_NAME

peer lifecycle chaincode install $CHAINCODE_NAME.tar.gz --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled
echo "Enter package id:::"
read CHAINCODE_PACKAGE_ID
export CHANNEL_ID=channelcorp
export version=1
export sequence=1

peer lifecycle chaincode approveformyorg -o $ORDERER_ENDPOINT --tls --cafile $TLS_ROOT_CA --channelID $CHANNEL_ID --name $CHAINCODE_NAME  --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --version $version --package-id $CHAINCODE_PACKAGE_ID --sequence $sequence  --signature-policy "AND ('Org1MSP.peer','Org2MSP.peer')"








# org2


export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/ca/crypto/Org2MSP/peers/peer0.khalil.com/tls/ca.crt
export CORE_PEER_MSPCONFIGPATH=${PWD}/ca/crypto/Org2MSP/users/admin.khalil.com/msp
export CORE_PEER_ADDRESS=peer0.khalil.com:10051
export TLS_ROOT_CA=${PWD}/ca/crypto/orderers/orderer0.ibrahim.com/tls/ca.crt
export PATH=${PWD}/../required-files/bin:$PATH
export FABRIC_CFG_PATH=${PWD}/../configtx
export CHAINCODE_NAME=basic
export CHAINCODE_PATH=${PWD}/chaincode/javascript
export ORDERER_ENDPOINT=orderer0.ibrahim.com:7050

peer lifecycle chaincode package $CHAINCODE_NAME.tar.gz --path $CHAINCODE_PATH --lang node --label $CHAINCODE_NAME
peer lifecycle chaincode install $CHAINCODE_NAME.tar.gz --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled
echo "Enter package id:::"
read CHAINCODE_PACKAGE_ID
export CHANNEL_ID=channelcorp
export version=1
export sequence=1

peer lifecycle chaincode approveformyorg -o $ORDERER_ENDPOINT --tls --cafile $TLS_ROOT_CA --channelID $CHANNEL_ID --name $CHAINCODE_NAME  --peerAddresses $CORE_PEER_ADDRESS --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE --version $version --package-id $CHAINCODE_PACKAGE_ID --sequence $sequence  --signature-policy "AND ('Org1MSP.peer','Org2MSP.peer')"



export PEER0_ORG1_ADDRESS=peer0.ibrahim.com:9051
export PEER0_ORG2_ADDRESS=peer0.khalil.com:10051
export PEER0_ORG1_ROOT_CERT=${PWD}/ca/crypto/Org1MSP/peers/peer0.ibrahim.com/tls/ca.crt
export PEER0_ORG2_ROOT_CERT=${PWD}/ca/crypto/Org2MSP/peers/peer0.khalil.com/tls/ca.crt

peer lifecycle chaincode commit -o $ORDERER_ENDPOINT --tls --cafile $TLS_ROOT_CA --channelID $CHANNEL_ID --name $CHAINCODE_NAME --version $version --sequence $version --peerAddresses $PEER0_ORG1_ADDRESS --tlsRootCertFiles $PEER0_ORG1_ROOT_CERT  --peerAddresses $PEER0_ORG2_ADDRESS --tlsRootCertFiles $PEER0_ORG2_ROOT_CERT  --signature-policy "AND ('Org1MSP.peer','Org2MSP.peer')"


peer chaincode invoke -o $ORDERER_ENDPOINT --tls --cafile $TLS_ROOT_CA -C $CHANNEL_ID -n $CHAINCODE_NAME --peerAddresses $PEER0_ORG1_ADDRESS --tlsRootCertFiles $PEER0_ORG1_ROOT_CERT --peerAddresses $PEER0_ORG2_ADDRESS --tlsRootCertFiles $PEER0_ORG2_ROOT_CERT -c '{"function":"initLedger","Args":[]}'



peer chaincode query -o $ORDERER_ENDPOINT --tls --cafile $TLS_ROOT_CA -C $CHANNEL_ID -n $CHAINCODE_NAME --peerAddresses $PEER0_ORG1_ADDRESS --tlsRootCertFiles $PEER0_ORG1_ROOT_CERT -c '{"function":"queryAllCars","Args":[]}'


