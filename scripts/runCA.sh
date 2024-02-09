#!/bin/bash

docker-compose -f $4 up -d

#add path of fabric ca client binary
export PATH=$PATH:../ca
#export path of ca server home
export FABRIC_CA_CLIENT_HOME=../ca/crypto
export FABRIC_CA_SERVER_PATH=../ca-server
#enroll admin for ca to operate ca
echo "ca server is deploying..."
sleep 5
fabric-ca-client enroll -u https://$2:$3@localhost:7054 --caname $1 --csr.hosts '*.propvalchain.com,localhost' --tls.certfiles $FABRIC_CA_SERVER_PATH/tls-cert.pem 

cd $FABRIC_CA_CLIENT_HOME/msp

touch config.yaml

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
    " > config.yaml





