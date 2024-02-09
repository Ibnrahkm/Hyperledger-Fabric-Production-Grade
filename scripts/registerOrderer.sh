#!/bin/bash
#add path of fabric ca client binary
export PATH=$PATH:../ca
#export path of ca server home
export FABRIC_CA_CLIENT_HOME=../ca/crypto
export FABRIC_CA_SERVER_PATH=../ca-server

fabric-ca-client register --caname $1 --id.name $2 --id.secret $3 --id.type orderer --id.attrs '"hf.Registrar.Roles=orderer"' --tls.certfiles $FABRIC_CA_SERVER_PATH/tls-cert.pem





