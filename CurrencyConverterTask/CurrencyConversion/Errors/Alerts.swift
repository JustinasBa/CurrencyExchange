//
//  ProgressView.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/28/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation


class Alerts {
    
    class func calculateRequestFailedAlert() {
        let alert = UIAlertController(title: "Failure", message: "Something wrong happen with request", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        let topViewController = UIApplication.shared.keyWindow?.rootViewController
        topViewController?.present(alert, animated: true, completion: nil)
    }
}
