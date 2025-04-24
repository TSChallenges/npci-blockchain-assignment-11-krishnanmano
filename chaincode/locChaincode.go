package main

import (
	"encoding/json"
	"fmt"

	"github.com/hyperledger/fabric-contract-api-go/contractapi"
)

// LetterOfCredit defines the structure for the Letter of Credit
type LetterOfCredit struct {
	LOCID            string   `json:"locId"`
	Buyer            string   `json:"buyer"`
	Seller           string   `json:"seller"`
	IssuingBank      string   `json:"issuingBank"`
	AdvisingBank     string   `json:"advisingBank"`
	Amount           string   `json:"amount"`
	Currency         string   `json:"currency"`
	ExpiryDate       string   `json:"expiryDate"`
	GoodsDescription string   `json:"goodsDescription"`
	Status           string   `json:"status"`
	DocumentHashes   []string `json:"documentHashes"`
	History          []string `json:"history"`
}

// SmartContract provides functions for managing the Letter of Credit
type SmartContract struct {
	contractapi.Contract
}

// InitLedger initializes the chaincode (optional)
func (s *SmartContract) InitLedger(ctx contractapi.TransactionContextInterface) error {
	// TODO: Initialization code if needed
	return nil
}

// RequestLOC creates a new LoC request
func (s *SmartContract) RequestLOC(ctx contractapi.TransactionContextInterface, locID string, buyer string, seller string, issuingBank string, advisingBank string, amount string, currency string, expiryDate string, goodsDescription string) error {

	var (
		mspID string
		err   error
	)

	if mspID, err = ctx.GetClientIdentity().GetMSPID(); err != nil {
		return fmt.Errorf("unable to read mspID")
	}

	if mspID != "TataMotors" {
		return fmt.Errorf("only TataMotors can create a new LOC")
	}

	var loc = LetterOfCredit{
		LOCID:            locID,
		Buyer:            buyer,
		Seller:           seller,
		IssuingBank:      issuingBank,
		AdvisingBank:     advisingBank,
		Amount:           amount,
		Currency:         currency,
		ExpiryDate:       expiryDate,
		GoodsDescription: goodsDescription,
		Status:           "Requested",
		History:          []string{"TataMotors|LOC_Requested"},
	}

	locdata, err := json.Marshal(loc)
	if err != nil {
		return err
	}

	err = ctx.GetStub().PutState(locID, locdata)
	if err != nil {
		return err
	}

	return nil
}

func (s *SmartContract) IssueLOC(ctx contractapi.TransactionContextInterface, locID string) error {

	var (
		mspID string
		err   error
	)

	if mspID, err = ctx.GetClientIdentity().GetMSPID(); err != nil {
		return fmt.Errorf("unable to read mspID")
	}

	if mspID != "ICICIBank" {
		return fmt.Errorf("only ICICIBank can issue LOC")
	}

	locData, err := ctx.GetStub().GetState(locID)
	if err != nil {
		return err
	}

	var loc LetterOfCredit
	err = json.Unmarshal(locData, &loc)
	if err != nil {
		return err
	}

	loc.Status = "Issued"
	loc.History = append(loc.History, "ICICIBank|LOC_Issued")

	locdata, err := json.Marshal(loc)
	if err != nil {
		return err
	}

	err = ctx.GetStub().PutState(locID, locdata)
	if err != nil {
		return err
	}

	err = ctx.GetStub().SetEvent("LOC_ISSUED", locData)
	if err != nil {
		return err
	}

	return nil
}

func (s *SmartContract) AcceptLOC(ctx contractapi.TransactionContextInterface, locID string) error {

	var (
		mspID string
		err   error
	)

	if mspID, err = ctx.GetClientIdentity().GetMSPID(); err != nil {
		return fmt.Errorf("unable to read mspID")
	}

	if mspID != "Tesla" {
		return fmt.Errorf("only Tesla can accept LOC")
	}

	locData, err := ctx.GetStub().GetState(locID)
	if err != nil || locData == nil {
		return err
	}

	var loc LetterOfCredit
	err = json.Unmarshal(locData, &loc)
	if err != nil {
		return err
	}

	loc.Status = "Accepted"
	loc.History = append(loc.History, "Tesla|LOC_Accepted")

	locdata, err := json.Marshal(loc)
	if err != nil {
		return err
	}

	err = ctx.GetStub().PutState(locID, locdata)
	if err != nil {
		return err
	}

	return nil
}

func (s *SmartContract) ShipGoods(ctx contractapi.TransactionContextInterface, locID string) error {

	var (
		mspID string
		err   error
	)

	if mspID, err = ctx.GetClientIdentity().GetMSPID(); err != nil {
		return fmt.Errorf("unable to read mspID")
	}

	if mspID != "Tesla" {
		return fmt.Errorf("only Tesla can ship goods")
	}

	locData, err := ctx.GetStub().GetState(locID)
	if err != nil || locData == nil {
		return err
	}

	var loc LetterOfCredit
	err = json.Unmarshal(locData, &loc)
	if err != nil {
		return err
	}

	loc.Status = "Shipped"
	loc.History = append(loc.History, "Tesla|Shipped_Goods")
	loc.DocumentHashes = []string{"Tesla|Docs_Passed"}

	locdata, err := json.Marshal(loc)
	if err != nil {
		return err
	}

	err = ctx.GetStub().PutState(locID, locdata)
	if err != nil {
		return err
	}

	err = ctx.GetStub().SetEvent("SHIPPED_GOODS", locData)
	if err != nil {
		return err
	}

	return nil
}

func (s *SmartContract) VerifyDocuments(ctx contractapi.TransactionContextInterface, locID string) error {

	var (
		mspID string
		err   error
	)

	if mspID, err = ctx.GetClientIdentity().GetMSPID(); err != nil {
		return fmt.Errorf("unable to read mspID")
	}

	if mspID != "ChaseBank" {
		return fmt.Errorf("only ChaseBank can ship goods")
	}

	locData, err := ctx.GetStub().GetState(locID)
	if err != nil || locData == nil {
		return err
	}

	var loc LetterOfCredit
	err = json.Unmarshal(locData, &loc)
	if err != nil {
		return err
	}

	loc.Status = "Verified"
	loc.History = append(loc.History, "ChaseBank|Verified")
	loc.DocumentHashes = append(loc.DocumentHashes, "ChaseBank|Docs_Verified")

	locdata, err := json.Marshal(loc)
	if err != nil {
		return err
	}

	err = ctx.GetStub().PutState(locID, locdata)
	if err != nil {
		return err
	}

	err = ctx.GetStub().SetEvent("DOCUMENTS_VERIFIED", locData)
	if err != nil {
		return err
	}

	return nil
}

func (s *SmartContract) ReleasePayment(ctx contractapi.TransactionContextInterface, locID string) error {

	var (
		mspID string
		err   error
	)

	if mspID, err = ctx.GetClientIdentity().GetMSPID(); err != nil {
		return fmt.Errorf("unable to read mspID")
	}

	if mspID != "ICICIBank" {
		return fmt.Errorf("only ICICIBank can release payment")
	}

	locData, err := ctx.GetStub().GetState(locID)
	if err != nil || locData == nil {
		return err
	}

	var loc LetterOfCredit
	err = json.Unmarshal(locData, &loc)
	if err != nil {
		return err
	}

	loc.Status = "Paid"
	loc.History = append(loc.History, "ICICIBank|Paid")

	locdata, err := json.Marshal(loc)
	if err != nil {
		return err
	}

	err = ctx.GetStub().PutState(locID, locdata)
	if err != nil {
		return err
	}

	err = ctx.GetStub().SetEvent("RELEASED_PAYMENTS", locData)
	if err != nil {
		return err
	}

	return nil
}

func (s *SmartContract) GetLOCHistory(ctx contractapi.TransactionContextInterface, locID string) ([]string, error) {

	var loc = LetterOfCredit{}
	var err error

	locData, err := ctx.GetStub().GetState(locID)
	if err != nil || locData == nil {
		return loc.History, err
	}

	err = json.Unmarshal(locData, &loc)
	if err != nil {
		return loc.History, err
	}

	return loc.History, nil
}

func (s *SmartContract) GetLOCStatus(ctx contractapi.TransactionContextInterface, locID string) (string, error) {

	var loc = LetterOfCredit{}
	var err error

	locData, err := ctx.GetStub().GetState(locID)
	if err != nil || locData == nil {
		return loc.Status, err
	}

	err = json.Unmarshal(locData, &loc)
	if err != nil {
		return loc.Status, err
	}

	return loc.Status, nil
}

func main() {
	chaincode, err := contractapi.NewChaincode(&SmartContract{})
	if err != nil {
		fmt.Printf("Error creating loc chaincode: %s", err.Error())
		return
	}

	if err := chaincode.Start(); err != nil {
		fmt.Printf("Error starting loc chaincode: %s", err.Error())
	}
}
