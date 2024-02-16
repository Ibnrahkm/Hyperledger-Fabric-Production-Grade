#!/bin/bash

ORDERER_MSP=../ca/crypto/orderers/orderer0.ibrahim.com/msp

../required-files/bin/configtxgen -profile OrdererGenesis -channelID system-channel -outputBlock ../volumes/orderer/system-genesis-block/genesis.block --configPath ../configtx
