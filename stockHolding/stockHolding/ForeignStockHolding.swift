//
//  ForeignStockHolding.swift
//  stockHolding
//
//  Created by Shijith K  on 01/06/22.
//

import Foundation

public class ForeignStockHolding: StockHolding {
    var conversionRate: Float = 0.0
    
    init(foreignStockId: Int, foreignCompanyName: String, foreignPurchaseSharePrice: Float, foreignCurrentSharePrice: Float,
         foreignNumberOfShares: Int, conversionRate: Float)
    {
        self.conversionRate = conversionRate
        super.init(
            stockId: foreignStockId,
            companyName: foreignCompanyName,
            purchaseSharePrice: foreignPurchaseSharePrice,
            currentSharePrice: foreignCurrentSharePrice,
            numberOfShares: foreignNumberOfShares
        )
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
