#!/bin/bash

# Environment variables for Org1 (TataMotors)

PATH=${PWD}/../fabric-samples/bin:$PATH
FABRIC_CFG_PATH=$PWD/../fabric-samples/config/
CORE_PEER_TLS_ENABLED=true
CORE_PEER_LOCALMSPID="TataMotors"
CORE_PEER_TLS_ROOTCERT_FILE=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/peers/peer0.TataMotors.example.com/tls/ca.crt
CORE_PEER_MSPCONFIGPATH=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/users/Admin@TataMotors.example.com/msp
CORE_PEER_ADDRESS=localhost:7051

# Path to binary
export PATH=${PWD}/../bin:$PATH

# FABRIC_CFG_PATH
export FABRIC_CFG_PATH=${PWD}/configtx
