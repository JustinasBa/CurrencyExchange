//
//  Account.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/30/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation
import RealmSwift


final class Account: Object {
    
    dynamic var currency = ""
    dynamic var amount = ""
    dynamic var complete = false
    
    func getAmountOfMoney() -> Money {
        return Money(amountString: amount, currency: currency)
    }
}
