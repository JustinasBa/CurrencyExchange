//
//  ViewController.swift
//  CurrencyConverterTask
//
//  Created by Vytautas Gimbutas on 8/22/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    fileprivate var currencyConversionApiClient: CurrencyConversionApiClient
    
    init(currencyConversionApiClient: CurrencyConversionApiClient) {
        self.currencyConversionApiClient = currencyConversionApiClient
        
        super.init()
    }
    
    override func getView() -> MainView {
        return self.view as! MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getView().delegate = self
        
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.view = self.getView()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MainViewController: MainViewDelegate {
    
    func onConvertionButtonClicked(fromMoney: Money, toCurrency: String) {
        let _ =  currencyConversionApiClient
            .calculate(fromAmount: fromMoney, toCurrency: toCurrency)
            .continueWith { task in
                print("calculate: ", task.result?.getAmount())
        }
    }
}

