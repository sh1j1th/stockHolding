//
//  helperFunctions.swift
//  stockHolding
//
//  Created by Shijith K  on 01/06/22.
//

import Foundation

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

public func loadLocalStockData(_ filename: String) -> [StockHolding]? {
    if let url = Bundle.main.url(forResource: filename, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([StockHolding].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
