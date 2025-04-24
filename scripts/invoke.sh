PATH=${PWD}/../fabric-samples/bin:$PATH
FABRIC_CFG_PATH=$PWD/../fabric-samples/config/
CORE_PEER_TLS_ENABLED=true
CORE_PEER_LOCALMSPID="TataMotors"
CORE_PEER_TLS_ROOTCERT_FILE=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/peers/peer0.TataMotors.example.com/tls/ca.crt
CORE_PEER_MSPCONFIGPATH=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/users/Admin@TataMotors.example.com/msp
CORE_PEER_ADDRESS=localhost:7051

echo "Register LOC"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C locchannel -n locChaincode --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/peers/peer0.TataMotors.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/Tesla.example.com/peers/peer0.Tesla.example.com/tls/ca.crt" --peerAddresses localhost:13051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/peers/peer0.ICICIBank.example.com/tls/ca.crt" --peerAddresses localhost:15051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ChaseBank.example.com/peers/peer0.ChaseBank.example.com/tls/ca.crt" -c '{"function":"RequestLOC","Args":["LOC_1001", "TataMotors", "Tesla", "ICICIBank","ChaseBank", "1000", "USD", "23/09/2030", "New Car"]}'

sleep 2
echo "Query LOC"
peer chaincode query -C locchannel -n locChaincode -c '{"Args":["GetLOCHistory", "LOC_1001"]}'

CORE_PEER_LOCALMSPID="ICICIBank"
CORE_PEER_TLS_ROOTCERT_FILE=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/peers/peer0.ICICIBank.example.com/tls/ca.crt
CORE_PEER_MSPCONFIGPATH=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/users/Admin@ICICIBank.example.com/msp
CORE_PEER_ADDRESS=localhost:13051

echo "Issue LOC"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C locchannel -n locChaincode --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/peers/peer0.TataMotors.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/Tesla.example.com/peers/peer0.Tesla.example.com/tls/ca.crt" --peerAddresses localhost:13051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/peers/peer0.ICICIBank.example.com/tls/ca.crt" --peerAddresses localhost:15051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ChaseBank.example.com/peers/peer0.ChaseBank.example.com/tls/ca.crt" -c '{"function":"IssueLOC","Args":["LOC_1001"]}'

sleep 2
echo "Query LOC"
peer chaincode query -C locchannel -n locChaincode -c '{"Args":["GetLOCHistory", "LOC_1001"]}'

CORE_PEER_LOCALMSPID="Tesla"
CORE_PEER_TLS_ROOTCERT_FILE=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/Tesla.example.com/peers/peer0.Tesla.example.com/tls/ca.crt
CORE_PEER_MSPCONFIGPATH=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/Tesla.example.com/users/Admin@Tesla.example.com/msp
CORE_PEER_ADDRESS=localhost:9051

echo "Accept LOC"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C locchannel -n locChaincode --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/peers/peer0.TataMotors.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/Tesla.example.com/peers/peer0.Tesla.example.com/tls/ca.crt" --peerAddresses localhost:13051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/peers/peer0.ICICIBank.example.com/tls/ca.crt" --peerAddresses localhost:15051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ChaseBank.example.com/peers/peer0.ChaseBank.example.com/tls/ca.crt" -c '{"function":"AcceptLOC","Args":["LOC_1001"]}'

sleep 2
echo "Query LOC"
peer chaincode query -C locchannel -n locChaincode -c '{"Args":["GetLOCHistory", "LOC_1001"]}'

echo "Ship Goods"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C locchannel -n locChaincode --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/peers/peer0.TataMotors.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/Tesla.example.com/peers/peer0.Tesla.example.com/tls/ca.crt" --peerAddresses localhost:13051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/peers/peer0.ICICIBank.example.com/tls/ca.crt" --peerAddresses localhost:15051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ChaseBank.example.com/peers/peer0.ChaseBank.example.com/tls/ca.crt" -c '{"function":"ShipGoods","Args":["LOC_1001"]}'

sleep 2
echo "Query LOC"
peer chaincode query -C locchannel -n locChaincode -c '{"Args":["GetLOCHistory", "LOC_1001"]}'

CORE_PEER_LOCALMSPID="ChaseBank"
CORE_PEER_TLS_ROOTCERT_FILE=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/ChaseBank.example.com/peers/peer0.ChaseBank.example.com/tls/ca.crt
CORE_PEER_MSPCONFIGPATH=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/ChaseBank.example.com/users/Admin@ChaseBank.example.com/msp
CORE_PEER_ADDRESS=localhost:15051

echo "Authenticate"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C locchannel -n locChaincode --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/peers/peer0.TataMotors.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/Tesla.example.com/peers/peer0.Tesla.example.com/tls/ca.crt" --peerAddresses localhost:13051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/peers/peer0.ICICIBank.example.com/tls/ca.crt" --peerAddresses localhost:15051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ChaseBank.example.com/peers/peer0.ChaseBank.example.com/tls/ca.crt" -c '{"function":"VerifyDocuments","Args":["LOC_1001"]}'

sleep 2
echo "Query LOC"
peer chaincode query -C locchannel -n locChaincode -c '{"Args":["GetLOCHistory", "LOC_1001"]}'

CORE_PEER_LOCALMSPID="ICICIBank"
CORE_PEER_TLS_ROOTCERT_FILE=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/peers/peer0.ICICIBank.example.com/tls/ca.crt
CORE_PEER_MSPCONFIGPATH=$PWD/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/users/Admin@ICICIBank.example.com/msp
CORE_PEER_ADDRESS=localhost:13051

echo "Repayment Drug"
peer chaincode invoke -o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../fabric-samples/test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -C locchannel -n locChaincode --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/TataMotors.example.com/peers/peer0.TataMotors.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/Tesla.example.com/peers/peer0.Tesla.example.com/tls/ca.crt" --peerAddresses localhost:13051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ICICIBank.example.com/peers/peer0.ICICIBank.example.com/tls/ca.crt" --peerAddresses localhost:15051 --tlsRootCertFiles "${PWD}/../fabric-samples/test-network/organizations/peerOrganizations/ChaseBank.example.com/peers/peer0.ChaseBank.example.com/tls/ca.crt" -c '{"function":"ReleasePayment","Args":["LOC_1001"]}'

sleep 2
echo "Query LOC"
peer chaincode query -C locchannel -n locChaincode -c '{"Args":["GetLOCHistory", "LOC_1001"]}'