//
//  AppDelegate.swift
//  CurrencyConverterTask
//
//  Created by Vytautas Gimbutas on 8/22/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import UIKit
import Typhoon

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainRouter: MainRouter!
    var mainAssembly: MainAssembly!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.initializeDependencyContainer()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.makeKeyAndVisible()
        mainRouter.showMain { (true) -> (Void) in
            print("SHowed up")
        }
        
        return true
    }

    private func initializeDependencyContainer() {
        let factory = TyphoonBlockComponentFactory(assemblies: [
            MainAssembly(),
        ]) as! TyphoonBlockComponentFactory
        
        factory.makeDefault()
        factory.inject(self)
    }
}

