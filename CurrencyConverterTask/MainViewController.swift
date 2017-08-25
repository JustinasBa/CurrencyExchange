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
    var money: Money
    
    init(currencyConversionApiClient: CurrencyConversionApiClient) {
        self.currencyConversionApiClient = currencyConversionApiClient
        money = Money(amount: 20, currency: "USD")
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
    
    func onConvertionButtonClicked() {
        let _ =  currencyConversionApiClient
            .calculate(fromAmount: money, toCurrency: "EUR")
            .continueWith { task in
                print("calculate: ", task.result?.amount)
        }
    }
}

