#!/bin/bash
#add path of fabric ca client binary
export PATH=$PATH:../required-files/bin
#export path of ca server home
export FABRIC_CA_CLIENT_HOME=../ca/crypto
export FABRIC_CA_SERVER_PATH=../ca-server

fabric-ca-client enroll -u https://$2:$3@localhost:7054 --caname $1 -M ../crypto/$4/peers/$5/msp --csr.hosts '$5,*.propvalchain.com,localhost' --tls.certfiles $FABRIC_CA_SERVER_PATH/tls-cert.pem

fabric-ca-client enroll -u https://$2:$3@localhost:7054 --caname $1 -M ../crypto/$4/peers/$5/tls --enrollment.profile tls --csr.hosts '$5,*.propvalchain.com,localhost' --tls.certfiles $FABRIC_CA_SERVER_PATH/tls-cert.pem

mkdir ../ca/crypto/$4/msp

echo "
NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-7054-capropvalchain.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-7054-capropvalchain.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-7054-capropvalchain.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-7054-capropvalchain.pem
    OrganizationalUnitIdentifier: orderer
    " >../ca/crypto/$4/msp/config.yaml
    
    
cp ../ca/crypto/$4/msp/config.yaml ../ca/crypto/$4/peers/$5/msp/config.yaml


cp ../ca/crypto/$4/peers/$5/tls/tlscacerts/* ../ca/crypto/$4/peers/$5/tls/ca.crt
cp ../ca/crypto/$4/peers/$5/tls/signcerts/* ../ca/crypto/$4/peers/$5/tls/server.crt
cp ../ca/crypto/$4/peers/$5/tls/keystore/* ../ca/crypto/$4/peers/$5/tls/server.key

mkdir -p ../ca/crypto/$4/msp/tlscacerts
cp ../ca/crypto/$4/peers/$5/tls/tlscacerts/* ../ca/crypto/$4/msp/tlscacerts/ca.crt

mkdir -p ../ca/crypto/$4/tlsca
cp ../ca/crypto/$4/peers/$5/tls/tlscacerts/* ../ca/crypto/$4/tlsca/tlsca.$4-cert.pem

mkdir -p ../ca/crypto/$4/ca
cp ../ca/crypto/$4/peers/$5/msp/cacerts/* ../ca/crypto/$4/ca/ca.$4-cert.pem

