//
//  User.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/30/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

//import UIKit
import RealmSwift



class User: Object {
    
    dynamic var id = ""
    var accounts = List<Account>()
    
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
