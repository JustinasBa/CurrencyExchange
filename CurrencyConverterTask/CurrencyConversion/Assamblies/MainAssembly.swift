//
//  CurrencyConversionAssembly.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/22/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation


class MainAssembly: TyphoonAssembly {
    
   
    dynamic func appDelegate() -> AnyObject {
        return TyphoonDefinition.withClass(AppDelegate.self) {definition in
            definition?.injectProperty(#selector(self.mainRouter), with: self.mainRouter())
            definition?.scope = TyphoonScope.singleton
        } as AnyObject
    }
    
    dynamic func mainRouter() -> AnyObject {
        return TyphoonDefinition.withClass(MainRouter.self) { definition in
            definition?.useInitializer(#selector(MainRouter.init(mainAssembly:)), parameters: { initializer in
                initializer?.injectParameter(with: self)
            })
            definition?.scope = TyphoonScope.singleton
        } as AnyObject
    }

    dynamic func currencyConversionApiClient() -> AnyObject {
        return TyphoonDefinition.withClass(CurrencyConversionApiClient.self) { definition in
            definition?.scope = TyphoonScope.singleton
        } as AnyObject
    }
    
    dynamic func mainViewController() -> AnyObject {
        return TyphoonDefinition.withClass(MainViewController.self) { definition in
            definition?.useInitializer(#selector(MainViewController.init(currencyConversionApiClient:)), parameters: {
                initializer in
                
                initializer?.injectParameter(with: self.currencyConversionApiClient())
            })
            definition?.scope = TyphoonScope.prototype
        } as AnyObject
    }
}

    

