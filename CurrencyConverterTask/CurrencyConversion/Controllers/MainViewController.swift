//
//  ViewController.swift
//  CurrencyConverterTask
//
//  Created by Vytautas Gimbutas on 8/22/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import UIKit

enum ExhangeType {
    case Sell
    case Buy
}

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
    
    func showCurrencyPicker(currency: String, exhangeType: ExhangeType) {
        let holdingCurrencies = ["EUR","USD","JPY"]
        let currenciesOptions = UIAlertController(title: nil, message: "Choose currency: ", preferredStyle: .actionSheet)
        
        for currency in holdingCurrencies {
            currenciesOptions.addAction(UIAlertAction(title: currency, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                if exhangeType == .Sell {
                    self.getView().setSellingCurrency(currency: currency)
                } else if exhangeType == .Buy {
                    self.getView().setBuyingCurrency(currency: currency)
                }
            }))
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        currenciesOptions.addAction(cancelAction)
        self.present(currenciesOptions, animated: true, completion: nil)
    }

}


extension MainViewController: MainViewDelegate {
    
    func onSellCurrencyButtonClicked(fromMoney: Money, toCurrency: String) {
        let _ =  currencyConversionApiClient
            .calculate(fromAmount: fromMoney, toCurrency: toCurrency)
            .continueWith { task in
                if task.error != nil {
                    Alerts.calculateRequestFailedAlert()
                } else if let result = task.result {
                    print("calculate: ", result.getAmount())
                }
            }
    }
    func onBuyingCurrencySelectionClicked(currency: String) {
        self.showCurrencyPicker(currency: currency, exhangeType: .Buy)
    }
    func onSellingCurrencySelectionClicked(currency: String) {
        self.showCurrencyPicker(currency: currency, exhangeType: .Sell)
    }
}

