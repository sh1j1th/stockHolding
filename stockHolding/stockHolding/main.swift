//
//  main.swift
//  stockHolding
//
//  Created by Shijith K  on 01/06/22.
//

import Foundation
// Initialize global variables
var option: Int = 1
print(loadLocalStockData("localStockData")) //not working
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
        default:
            print("Invalid choice.")
            print("Please choose from the available options.")
            option = 0
            break
        }
    }
    
} while option != 9
print("Exiting application..Have a nice day :)")//or just redirect

