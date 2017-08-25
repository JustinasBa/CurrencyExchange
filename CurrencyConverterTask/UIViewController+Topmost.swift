//
//  UIViewController+Topmost.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/24/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func topmostController() -> UIViewController {
        var topController = rootViewController()
        
        while let controller = topController.presentedViewController  {
            topController = controller
        }
        
        return topController
    }
    
    func rootViewController() -> UIViewController {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard let rootViewController = appDelegate.window?.rootViewController else { return UIViewController() }
        return rootViewController
    }
   
    
}
