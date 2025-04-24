#!/bin/bash

function one_line_pem {
    echo "`awk 'NF {sub(/\\n/, ""); printf "%s\\\\\\\n",$0;}' $1`"
}

function json_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.json
}

function yaml_ccp {
    local PP=$(one_line_pem $4)
    local CP=$(one_line_pem $5)
    sed -e "s/\${ORG}/$1/" \
        -e "s/\${P0PORT}/$2/" \
        -e "s/\${CAPORT}/$3/" \
        -e "s#\${PEERPEM}#$PP#" \
        -e "s#\${CAPEM}#$CP#" \
        organizations/ccp-template.yaml | sed -e $'s/\\\\n/\\\n          /g'
}

ORG=1
P0PORT=7051
CAPORT=7054
PEERPEM=organizations/peerOrganizations/TataMotors.example.com/tlsca/tlsca.TataMotors.example.com-cert.pem
CAPEM=organizations/peerOrganizations/TataMotors.example.com/ca/ca.TataMotors.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/TataMotors.example.com/connection-TataMotors.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/TataMotors.example.com/connection-TataMotors.yaml

ORG=2
P0PORT=9051
CAPORT=8054
PEERPEM=organizations/peerOrganizations/Tesla.example.com/tlsca/tlsca.Tesla.example.com-cert.pem
CAPEM=organizations/peerOrganizations/Tesla.example.com/ca/ca.Tesla.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/Tesla.example.com/connection-Tesla.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/Tesla.example.com/connection-Tesla.yaml

ORG=4
P0PORT=13051
CAPORT=13054
PEERPEM=organizations/peerOrganizations/ICICIBank.example.com/tlsca/tlsca.ICICIBank.example.com-cert.pem
CAPEM=organizations/peerOrganizations/ICICIBank.example.com/ca/ca.ICICIBank.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/ICICIBank.example.com/connection-ICICIBank.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/ICICIBank.example.com/connection-ICICIBank.yaml

ORG=5
P0PORT=15051
CAPORT=15054
PEERPEM=organizations/peerOrganizations/ChaseBank.example.com/tlsca/tlsca.ChaseBank.example.com-cert.pem
CAPEM=organizations/peerOrganizations/ChaseBank.example.com/ca/ca.ChaseBank.example.com-cert.pem

echo "$(json_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/ChaseBank.example.com/connection-ChaseBank.json
echo "$(yaml_ccp $ORG $P0PORT $CAPORT $PEERPEM $CAPEM)" > organizations/peerOrganizations/ChaseBank.example.com/connection-ChaseBank.yaml
