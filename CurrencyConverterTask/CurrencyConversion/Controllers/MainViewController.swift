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
    
    func onCurrencyLabelClicked(label: UILabel) {
        let holdingCurrencies = ["EUR","USD","JPY"]
        let currenciesOptions = UIAlertController(title: nil, message: "Choose currency: ", preferredStyle: .actionSheet)
        
        for currency in holdingCurrencies {
            currenciesOptions.addAction(UIAlertAction(title: currency, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                if self.getView().fromCurrencyLabel == label {
                    self.getView().fromCurrencyLabel.text = currency
                } else if self.getView().toCurrencyLabel == label {
                    self.getView().toCurrencyLabel.text = currency
                }
            }))
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        currenciesOptions.addAction(cancelAction)
        self.present(currenciesOptions, animated: true, completion: nil)
    }
}

