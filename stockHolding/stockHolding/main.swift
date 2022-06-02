//
//  main.swift
//  stockHolding
//
//  Created by Shijith K  on 01/06/22.
//

import Foundation
// Initialize global variables
var option: Int = 1
var foreignStockHolding : ForeignStockHolding
var localStockHolding : Dictionary<Int,StockHolding>

print("Welcome screen")



repeat {
    while option >= 0 && option <= 6 {
        showMenu()
        option = getUserInput()
        switch option {
        case 1:
            //func1
            print("Display stock with lowest value")
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
print("Exiting application..Have a nice day :)")//or just redirect


func LoadData(){
    
    localStockHolding = [1: StockHolding("Royal Bank Of Canada",10,10,20),
                         2:StockHolding("The Toronto-Dominion Bank",10,10,20),
                         3:[
                            "Enbridge Inc",
                            10,
                            10,
                            20
                         ],
                         4:[
                            "Brookfield Asset Management Inc.",
                            10,
                            10,
                            20
                         ],
                         5:[
                            "The Bank Of Nova Scotia",
                            10,
                            10,
                            20
                         ],
                         6:[
                            "Canadian Pacific Railway Limited",
                            10,
                            10,
                            20
                         ],
                         7:[
                            "Bank Of Montreal",
                            10,
                            10,
                            20
                         ],
                         8:[
                            "Canadian Natural Resources Limited",
                            10,
                            10,
                            20
                         ],
                         9:[
                            "Canadian National Railway Company",
                            10,
                            10,
                            20
                         ],
                         10:[
                            "Suncor Energy Inc.",
                            10,
                            10,
                            20
                         ]
    ]
}

func displayStockWithLowest(){
    
}
