//
//  helperFunctions.swift
//  stockHolding
//
//  Created by Shijith K  on 01/06/22.
//

import Foundation
import SwiftyTextTable

//MARK: - Display user menu
public func showMenu() {
    print("\nChoose option from below.")
    print("1 : Display stock with lowest value")
    print("2 : Display stock with highest value")
    print("3 : Display the most profitable stock")
    print("4 : Display the least profitable stock")
    print("5 : List all stocks sorted by company name (A-Z)")
    print("6 : List all stocks sorted from the lowest value to the highest value")
    print("9 : Exit")
}

public func getUserInput() -> Int {
    var userChoice: Int = 0
    print("Choose an option: ", terminator: "")
    userChoice = Int(readLine(strippingNewline: true) ?? "0") ?? 0
    return userChoice
}

public func loadLocalStockData(_ localStockData: [StockHolding]) -> [StockHolding] {
    let stockId = TextTableColumn(header: "Stock Id")
    let companyName = TextTableColumn(header: "Company Name")
    let currentSharePrice = TextTableColumn(header: "Current Share Price(CAD)")
    let purchaseSharePrice = TextTableColumn(header: "Purchase Share Price(CAD)")
    let numberOfShares = TextTableColumn(header: "Number of Shares")
    let stockData = localStockData.sorted(by: {$0.companyName < $1.companyName})
    
    // Then create a table with the columns
    var table = TextTable(columns: [stockId, companyName, currentSharePrice, purchaseSharePrice, numberOfShares])
    table.header = "Local Stock Information"
    // Then add some rows
    for (index, i) in stockData.enumerated(){
        stockData[index].stockId = index + 1
        table.addRow(values: [index + 1,
                              i.companyName,
                              i.currentSharePrice,
                              i.purchaseSharePrice,
                              i.numberOfShares])
    }
    
    // Then render the table and use
    let tableString = table.render()
    print(tableString)
    return stockData
}

public func loadForeignStockData(_ foreignStockData: [ForeignStockHolding], _ isUserData: Bool) -> [ForeignStockHolding] {
    let stockId = TextTableColumn(header: "Stock Id")
    let companyName = TextTableColumn(header: "Company Name")
    let currentSharePrice = TextTableColumn(header: "Current Share Price")
    let purchaseSharePrice = TextTableColumn(header: "Purchase Share Price")
    let numberOfShares = TextTableColumn(header: "Number of Shares")
    let conversionRate = TextTableColumn(header: "Conversion Rate")
    let stockData = foreignStockData.sorted(by: {$0.companyName > $1.companyName})
    
    // Then create a table with the columns
    var table = TextTable(columns: [stockId, companyName, currentSharePrice, purchaseSharePrice, numberOfShares, conversionRate])
    table.header = isUserData == true ? "Purchased Stock Information" : "Foreign Stock Information"
    // Then add some rows
    for (index, i) in stockData.enumerated(){
        stockData[index].stockId = index + 1
        if i.conversionRate == 1.0 {
            table.addRow(values: [index + 1,
                                  i.companyName,
                                  i.currentSharePrice,
                                  i.purchaseSharePrice,
                                  i.numberOfShares])
        } else {
            table.addRow(values: [index + 1,
                                  i.companyName,
                                  i.currentSharePrice,
                                  i.purchaseSharePrice,
                                  i.numberOfShares,
                                  i.conversionRate])
        }
        
    }
    
    // Then render the table and use
    let tableString = table.render()
    print(tableString)
    return stockData
}
