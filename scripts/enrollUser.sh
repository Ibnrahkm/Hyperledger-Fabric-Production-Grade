#!/bin/bash
#add path of fabric ca client binary
export PATH=$PATH:../required-files/bin
#export path of ca server home
export FABRIC_CA_CLIENT_HOME=../ca/crypto
export FABRIC_CA_SERVER_PATH=../ca-server






fabric-ca-client enroll -u https://$2:$3@localhost:7054 --caname $1 -M ../crypto/$4/users/$5/msp --csr.hosts $5 --tls.certfiles $FABRIC_CA_SERVER_PATH/tls-cert.pem

fabric-ca-client enroll -u https://$2:$3@localhost:7054 --caname $1 -M ../crypto/$4/users/$5/tls --enrollment.profile tls --csr.hosts $5 --csr.hosts localhost --tls.certfiles $FABRIC_CA_SERVER_PATH/tls-cert.pem


cp ../ca/crypto/$4/users/$5/tls/tlscacerts/* ../ca/crypto/$4/users/$5/tls/ca.crt
cp ../ca/crypto/$4/users/$5/tls/signcerts/* ../ca/crypto/$4/users/$5/tls/server.crt
cp ../ca/crypto/$4/users/$5/tls/keystore/* ../ca/crypto/$4/users/$5/tls/server.key

cd ../ca/crypto/$4/users/$5/msp

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


