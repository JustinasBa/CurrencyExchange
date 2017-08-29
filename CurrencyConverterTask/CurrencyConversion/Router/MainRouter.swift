//
//  Router.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/24/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import UIKit

class MainRouter: Router {
    
    fileprivate let mainAssembly: MainAssembly
    
    init(mainAssembly: MainAssembly) {
        
        self.mainAssembly = mainAssembly
        super.init()
    }
    
    func showMain(onCompletion completion: ((Bool) -> (Void))?) {
        let mainViewController = mainAssembly.mainViewController() as! MainViewController
        let window = UIApplication.shared.delegate!.window!!
        
        UIApplication.shared.keyWindow?.rootViewController = mainViewController
        UIView.transition(
            with: window,
            duration: 0,
            options: .transitionCrossDissolve,
            animations: nil) { finish in
                completion?(true)
        }
    }
}
