//
//  ForeignStockHolding.swift
//  stockHolding
//
//  Created by Shijith K  on 01/06/22.
//

import Foundation

public class ForeignStockHolding: StockHolding {
    var conversionRate: Float = 0.0
    
    init(foreignPurchaseSharePrice: Float, foreignCurrentSharePrice: Float,
         foreignNumberOfShares: Int, foreignCompanyName: String, conversionRate: Float)
    {
        self.conversionRate = conversionRate
        super.init(
            purchaseSharePrice: foreignPurchaseSharePrice,
            currentSharePrice: foreignCurrentSharePrice,
            numberOfShares: foreignNumberOfShares,
            companyName: foreignCompanyName
        )
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override public func costInDollars () -> Float
    {
        return purchaseSharePrice * Float(numberOfShares) * conversionRate
    }
    
    override public func valueInDollars () -> Float
    {
        return currentSharePrice * Float(numberOfShares) * conversionRate
    }
}
