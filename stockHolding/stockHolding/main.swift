//
//  main.swift
//  stockHolding
//
//  Created by Shijith K  on 01/06/22.
//

import Foundation
import SwiftyTextTable


var localStockData: [StockHolding] = [StockHolding(stockId: 1, companyName: "Royal Bank Of Canada",purchaseSharePrice:
                                                    20,currentSharePrice: 10,numberOfShares: 50),
                                      StockHolding(stockId: 2, companyName: "The Toronto-Dominion Bank",purchaseSharePrice: 40,currentSharePrice: 30,numberOfShares: 20),
                                      StockHolding(stockId: 3, companyName: "Enbridge Inc",purchaseSharePrice: 30,currentSharePrice: 15,numberOfShares: 10),
                                      StockHolding(stockId: 4, companyName: "Brookfield Asset Management Inc.",purchaseSharePrice: 10,currentSharePrice: 20,numberOfShares: 25),
                                      StockHolding(stockId: 5, companyName: "The Bank Of Nova Scotia",purchaseSharePrice: 55,currentSharePrice: 102,numberOfShares: 10),
                                      StockHolding(stockId: 6, companyName: "Canadian Pacific Railway Limited",purchaseSharePrice: 60,currentSharePrice: 40,numberOfShares: 15),
                                      StockHolding(stockId: 7, companyName: "Bank Of Montreal",purchaseSharePrice: 34,currentSharePrice: 20,numberOfShares: 22),
                                      StockHolding(stockId: 8, companyName: "Canadian Natural Resources Limited",purchaseSharePrice: 100,currentSharePrice: 110,numberOfShares:30),
                                      StockHolding(stockId: 9, companyName: "Canadian National Railway Company",purchaseSharePrice: 90,currentSharePrice: 110,numberOfShares: 8),
                                      StockHolding(stockId: 10, companyName: "Suncor Energy Inc.",purchaseSharePrice: 15,currentSharePrice: 30,numberOfShares: 11)]

var foreignStockData: [ForeignStockHolding] = [ForeignStockHolding(foreignStockId: 1, foreignCompanyName: "RELIANCE INDUSTRIES LTD.",                                                                                  foreignPurchaseSharePrice:10,foreignCurrentSharePrice:
                                                                    15,foreignNumberOfShares: 20, conversionRate: 61.30),
                                               ForeignStockHolding(foreignStockId: 2, foreignCompanyName: "TATA CONSULTANCY SERVICES LTD.",foreignPurchaseSharePrice: 20,foreignCurrentSharePrice: 10,foreignNumberOfShares: 5, conversionRate: 61.30),
                                               ForeignStockHolding(foreignStockId: 3, foreignCompanyName: "INFOSYS LTD.",
                                                                   foreignPurchaseSharePrice: 40,foreignCurrentSharePrice:
                                                                    50,foreignNumberOfShares: 13, conversionRate: 61.30)]
var option: Int = 1
print("******Welcome to Stock Purchase Application******")

//local and foreign stock data
//Add package - https://github.com/scottrhoyt/SwiftyTextTable.git

localStockData = loadLocalStockData(localStockData)
foreignStockData = loadForeignStockData(foreignStockData)

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
    showUserData(userData, "") //show what user purchased so far, no need to modify any data
}

repeat {
    while option >= 0 && option <= 6 {
        showMenu()
        option = getUserInput()
        switch option { //this needs to be completed
        case 1:
            //func1
            print("\nDisplay stock with lowest value")
            let sortedUserData = userData.sorted(by: {$0.valueInDollars() < $1.valueInDollars()})
            showUserData([sortedUserData[0]], "(Stock with lowest value)")
        case 2:
            //func2
            print("\nDisplay stock with highest value")
            let sortedUserData = userData.sorted(by: {$0.valueInDollars() > $1.valueInDollars()})
            showUserData([sortedUserData[0]],"(Stock with highest value)")
        case 3:
            //func3
            print("\nDisplay the most profitable stock")
            let sortedUserData = userData.sorted(by: {$0.currentSharePrice - $0.purchaseSharePrice > $1.currentSharePrice - $1.purchaseSharePrice});

            showUserData([sortedUserData[0]], "(Most profitable stock)")
        case 4:
            //func4
            print("\nDisplay the least profitable stock")
            let sortedUserData = userData.sorted(by: {$0.currentSharePrice - $0.purchaseSharePrice < $1.currentSharePrice - $1.purchaseSharePrice});

            showUserData([sortedUserData[0]], "(Least profitable stock)")
        case 5:
            //func5
            print("\nList all stocks sorted by company name (A-Z)")
            let sortedUserData = userData.sorted(by: {$0.companyName < $1.companyName})
            showUserData(sortedUserData,"(All stocks sorted by company name (A-Z))")
        case 6:
            //func6
            print("\nList all stocks sorted from the lowest value to the highest value")
            let sortedUserData = userData.sorted(by: {$0.valueInDollars() < $1.valueInDollars()})
            showUserData(sortedUserData,"(All stocks sorted from the lowest value to the highest value)")
        case 9:
            option = 9
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

    if typeChoice == "1" || typeChoice == "2"{
        //enter stock id from the table
        print("\nEnter the stockId: ", terminator: "")
        if let stockId = readLine(){
            //if local stock
            if typeChoice == "1"{
                //get corresponding stock data
                let result = localStockData.filter { $0.stockId  == Int(stockId) }
                if result.isEmpty{
                    print("Incorrect stock id. No such stock available.\n")
                } else {
                    print("\(localStockData[Int(stockId)!-1].companyName) has \(localStockData[Int(stockId)!-1].numberOfShares) shares available for purchase.\n")
                    print("Enter no.of shares to purchase: ", terminator: "")
                    let sharesPurchased = Int(readLine() ?? "0") ?? 0
                    //check shares are within available limit
                    if sharesPurchased <= localStockData[Int(stockId)!-1].numberOfShares{
                        localStockData[Int(stockId)!-1].numberOfShares -= sharesPurchased
                        print("Congrats!!.. You purchased \(sharesPurchased) share(s) of \(localStockData[Int(stockId)!-1].companyName) successfully.\n")
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
                    print("\(foreignStockData[Int(stockId)!-1].companyName) has \(foreignStockData[Int(stockId)!-1].numberOfShares) shares available for purchase.\n")
                    print("Enter no.of shares: ", terminator: "")
                    let sharesPurchased = Int(readLine() ?? "0") ?? 0
                    if sharesPurchased <= foreignStockData[Int(stockId)!-1].numberOfShares{
                        foreignStockData[Int(stockId)!-1].numberOfShares -= sharesPurchased
                        print("Congrats!!.. You purchased \(sharesPurchased) share(s) of \(foreignStockData[Int(stockId)!-1].companyName) successfully.\n")
                        if userData.contains(where: {$0.companyName == result[0].companyName}){
                            let existingData = userData.filter({$0.companyName == result[0].companyName})
                            userData[existingData[1].stockId].numberOfShares += sharesPurchased
                        } else {
                            userData.append(ForeignStockHolding(foreignStockId: userData.count,
                                                                foreignCompanyName: result[0].companyName,
                                                                foreignPurchaseSharePrice:result[0].purchaseSharePrice,
                                                                foreignCurrentSharePrice:result[0].currentSharePrice,
                                                                foreignNumberOfShares: sharesPurchased,
                                                                conversionRate: result[0].conversionRate))
                        }
                    } else {
                        print("Number of shares exceeds availability. Please retry.\n")
                    }
                }
            }
        }
    }else{
        print("Invalid stock type. Please retry. \n")
    }
}
