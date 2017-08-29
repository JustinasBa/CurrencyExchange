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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension MainViewController: MainViewDelegate {
    
    func onSellCurrencyButtonClicked(fromCurrency currency: String, amount: String) {
        let money = Money(amountString: amount, currency: currency)
        let _ =  currencyConversionApiClient
            .calculate(fromAmount: money, toCurrency: "EUR")
            .continueWith { task in
                if task.error != nil {
                    Alerts.calculateRequestFailedAlert()
                } else {
                    print("calculate: ", task.result?.getAmount())
                }
        }
    }
}

