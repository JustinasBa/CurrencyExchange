//
//  CurrencyConversionResult.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/25/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation
import ObjectMapper

class CurrencyConversionResult: NSObject, Mappable {
    var amount: String?
    var currency: String?
    
    init(amount: String, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    required init?(map: Map) {
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        amount <- map["amount"]
        currency <- map["currency"]
    }
    
    func getAmount() -> Money {
        guard let amount = self.amount,
            let currency = self.currency else { return Money(amount: 0, currency: "EUR") }
        
        return Money(amountString: amount, currency: currency)
    }
    
}
