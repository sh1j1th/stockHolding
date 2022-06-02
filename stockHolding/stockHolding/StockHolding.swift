//
//  StockHolding.swift
//  stockHolding
//
//  Created by Shijith K  on 01/06/22.
//

import Foundation

public class StockHolding: Codable{
    
    // Variable declaration
    var purchaseSharePrice: Float = 0.0
    var currentSharePrice: Float = 0.0
    var numberOfShares: Int = 0
    var companyName: String = ""
    
    init(companyName: String, purchaseSharePrice: Float, currentSharePrice: Float, numberOfShares: Int)
    {
        self.purchaseSharePrice = purchaseSharePrice
        self.currentSharePrice  = currentSharePrice
        self.numberOfShares     = numberOfShares
        self.companyName        = companyName
    }
    
    // Closures
    public func costInDollars () -> Float
    {
        return purchaseSharePrice * Float(numberOfShares)
    }
    
    public func valueInDollars () -> Float
    {
        return currentSharePrice * Float(numberOfShares)
    }
}

