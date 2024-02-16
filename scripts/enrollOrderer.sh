#!/bin/bash
#add path of fabric ca client binary
export PATH=$PATH:../required-files/bin
#export path of ca server home
export FABRIC_CA_CLIENT_HOME=../ca/crypto
export FABRIC_CA_SERVER_PATH=../ca-server

fabric-ca-client enroll -u https://$2:$3@localhost:7054 --caname $1 -M ../crypto/orderers/$4/msp --csr.hosts $4 --tls.certfiles $FABRIC_CA_SERVER_PATH/tls-cert.pem

fabric-ca-client enroll -u https://$2:$3@localhost:7054 --caname $1 -M ../crypto/orderers/$4/tls --enrollment.profile tls --csr.hosts $4 --csr.hosts localhost --tls.certfiles $FABRIC_CA_SERVER_PATH/tls-cert.pem

cp ../ca/crypto/orderers/$4/tls/tlscacerts/tls-localhost-7054-caibrahim.pem* ../ca/crypto/orderers/$4/tls/ca.crt
cp ../ca/crypto/orderers/$4/tls/signcerts/cert.pem* ../ca/crypto/orderers/$4/tls/server.crt
cp ../ca/crypto/orderers/$4/tls/keystore/* ../ca/crypto/orderers/$4/tls/server.key
mkdir -p ../ca/crypto/orderers/$4/msp/tlscacerts
cp ../ca/crypto/orderers/$4/tls/tlscacerts/* ../ca/crypto/orderers/$4/msp/tlscacerts/tlsca.$4-cert.pem

cd ../ca/crypto/orderers/$4/msp

touch config.yaml

echo "
NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-caibrahim.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-caibrahim.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-caibrahim.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-caibrahim.pem
    OrganizationalUnitIdentifier: orderer
    " > config.yaml
