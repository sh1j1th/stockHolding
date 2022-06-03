//
//  main.swift
//  stockHolding
//
//  Created by Shijith K  on 01/06/22.
//

import Foundation
import SwiftyTextTable


//MARK: - Known issues/work pending
///there is only one userdata variable available now and it is of type foreignstockholding..so for local stocks, conversion rate will be 1 instead of empty..needs to be looked at
///please take a look at the menu...there needs to be some correction, its not exiting as expected
///DELETE userData.swift and all those json files please, i'm lazy
///need to make the whole input fetch part pretty...
///need to complete menu implementations..one sample is there but not complete
///could make code more granular with more functions
///setup a folder structure is necessary but dont think it adds any value
///dont move purchaseStocks() from main..makes accessing and modifying localStockData and foreignStockData harder
///need to handle more invalid value scenarios, and again, dont think it adds any value at the end

// data is currently in the form of array so as to make sorting easy
var localStockData: [StockHolding] = [StockHolding(stockId: 1, companyName: "Royal Bank Of Canada",purchaseSharePrice:
                                                    10,currentSharePrice: 10,numberOfShares: 20),
                                      StockHolding(stockId: 2, companyName: "The Toronto-Dominion Bank",purchaseSharePrice: 10,currentSharePrice: 10,numberOfShares: 20),
                                      StockHolding(stockId: 3, companyName: "Enbridge Inc",purchaseSharePrice: 10,currentSharePrice: 10,numberOfShares: 20),
                                      StockHolding(stockId: 4, companyName: "Brookfield Asset Management Inc.",purchaseSharePrice: 10,currentSharePrice: 10,numberOfShares: 20),
                                      StockHolding(stockId: 5, companyName: "The Bank Of Nova Scotia",purchaseSharePrice: 10,currentSharePrice: 10,numberOfShares: 20),
                                      StockHolding(stockId: 6, companyName: "Canadian Pacific Railway Limited",purchaseSharePrice: 10,currentSharePrice: 10,numberOfShares: 20),
                                      StockHolding(stockId: 7, companyName: "Bank Of Montreal",purchaseSharePrice: 10,currentSharePrice: 10,numberOfShares: 20),
                                      StockHolding(stockId: 8, companyName: "Canadian Natural Resources Limited",purchaseSharePrice: 10,currentSharePrice: 10,numberOfShares: 20),
                                      StockHolding(stockId: 9, companyName: "Canadian National Railway Company",purchaseSharePrice: 10,currentSharePrice: 10,numberOfShares: 20),
                                      StockHolding(stockId: 10, companyName: "Suncor Energy Inc.",purchaseSharePrice: 10,currentSharePrice: 10,numberOfShares: 20)]

var foreignStockData: [ForeignStockHolding] = [ForeignStockHolding(foreignStockId: 1, foreignCompanyName: "RELIANCE INDUSTRIES LTD.",                                                                                  foreignPurchaseSharePrice:10,foreignCurrentSharePrice:
                                                                    10,foreignNumberOfShares: 20, conversionRate: 61.30),
                                               ForeignStockHolding(foreignStockId: 2, foreignCompanyName: "TATA CONSULTANCY SERVICES LTD.",foreignPurchaseSharePrice: 10,foreignCurrentSharePrice: 10,foreignNumberOfShares: 20, conversionRate: 61.30),
                                               ForeignStockHolding(foreignStockId: 3, foreignCompanyName: "INFOSYS LTD.",
                                                                   foreignPurchaseSharePrice: 10,foreignCurrentSharePrice:
                                                                    10,foreignNumberOfShares: 20, conversionRate: 61.30)]
var option: Int = 1
print("******Welcome to Stock Purchase Application******")

//local and foreign stock data
//Add package - https://github.com/scottrhoyt/SwiftyTextTable.git

localStockData = loadLocalStockData(localStockData)
foreignStockData = loadForeignStockData(foreignStockData, false)

//user has to pick stock here
var userData: [ForeignStockHolding] = []
var userChoice = "Y"

if userData.isEmpty {
    repeat{
        purchaseStocks()
        print("Press Y to purchase more stocks or any other key to exit: ", terminator: "")
        userChoice = readLine() ?? "N"
    }while userChoice.uppercased() == "Y"
    print("\n\nHere is your purchase information")
    loadForeignStockData(userData, true) //show what user purchased so far, no need to modify any data
}

repeat {
    while option >= 0 && option <= 6 {
        showMenu()
        option = getUserInput()
        switch option { //this needs to be completed
        case 1:
            //func1
            print("Display stock with lowest value")
            print(userData.flatMap({$0.valueInDollars()}).min())
        case 2:
            //func2
            print("Display stock with highest value")
        case 3:
            //func3
            print("Display the most profitable stock")
        case 4:
            //func4
            print("Display the least profitable stock")
        case 5:
            //func5
            print("List all stocks sorted by company name (A-Z)")
        case 6:
            //func6
            print("List all stocks sorted from the lowest value to the highest value")
        default:
            print("Invalid choice.")
            print("Please choose from the available options.")
            option = 0
            break
        }
    }
    
} while option != 9
print("\nExiting application..Have a nice day :)")//or just redirect



public func purchaseStocks() {
    //pick a stock type
    print("\nAvailable stock types: \n 1. Local\t\t\t2. Foreign")
    print("\nChoose a stock type: ", terminator: "")
    let typeChoice = readLine()
    
    //enter stock id from the table
    print("\nEnter the stockId: ", terminator: "")
    if let stockId = readLine(){
        //if local stock
        if typeChoice == "1"{
            //get corresponding stock data
            let result = localStockData.filter { $0.stockId == Int(stockId) }
            if result.isEmpty{
                print("Incorrect stock id. No such stock available.\n")
            } else {
                print("\(localStockData[Int(stockId)!].companyName) has \(localStockData[Int(stockId)!].numberOfShares) shares available for purchase.\n")
                print("Enter no.of shares to purchase: ", terminator: "")
                let sharesPurchased = Int(readLine() ?? "0") ?? 0
                //check shares are within available limit
                if sharesPurchased <= localStockData[Int(stockId)!].numberOfShares{
                    localStockData[Int(stockId)!].numberOfShares -= sharesPurchased
                    print("Congrats!!.. You purchased \(sharesPurchased) share(s) of \(localStockData[Int(stockId)!].companyName) successfully.\n")
                    //if picking same shares again, check with company name and increment or else append as new
                    if userData.contains(where: {$0.companyName == result[0].companyName}){
                        let existingData = userData.filter({$0.companyName == result[0].companyName})
                        userData[existingData[0].stockId].numberOfShares += sharesPurchased
                    } else {
                        userData.append(ForeignStockHolding(foreignStockId: userData.count,
                                                            foreignCompanyName: result[0].companyName,
                                                            foreignPurchaseSharePrice:result[0].purchaseSharePrice,
                                                            foreignCurrentSharePrice:result[0].currentSharePrice,
                                                            foreignNumberOfShares: sharesPurchased,
                                                            conversionRate: 1.0))
                    }
                    
                } else {
                    print("Number of shares exceeds availability, please retry.\n")
                }
            }
            
            //same logic as above, could be separated into a function
        } else if typeChoice == "2" {
            let result = foreignStockData.filter { $0.stockId == Int(stockId) }
            if result.isEmpty{
                print("Incorrect stock id. No such stock available.\n")
            } else {
                print("\(foreignStockData[Int(stockId)!].companyName) has \(foreignStockData[Int(stockId)!].numberOfShares) shares available for purchase.\n")
                print("Enter no.of shares: ", terminator: "")
                let sharesPurchased = Int(readLine() ?? "0") ?? 0
                if sharesPurchased <= foreignStockData[Int(stockId)!].numberOfShares{
                    foreignStockData[Int(stockId)!].numberOfShares -= sharesPurchased
                    print("Congrats!!.. You purchased \(sharesPurchased) share(s) of \(foreignStockData[Int(stockId)!].companyName) successfully.\n")
                    if userData.contains(where: {$0.companyName == result[0].companyName}){
                        let existingData = userData.filter({$0.companyName == result[0].companyName})
                        userData[existingData[0].stockId].numberOfShares += sharesPurchased
                    } else {
                        userData.append(ForeignStockHolding(foreignStockId: userData.count,
                                                            foreignCompanyName: result[0].companyName,
                                                            foreignPurchaseSharePrice:result[0].purchaseSharePrice,
                                                            foreignCurrentSharePrice:result[0].currentSharePrice,
                                                            foreignNumberOfShares: sharesPurchased,
                                                            conversionRate: result[0].conversionRate))
                    }
                } else {
                    print("Number of shares exceeds availability, please retry.\n")
                }
            }
        }
    }
}