//
//  ViewController.swift
//  CurrencyConverterTask
//
//  Created by Vytautas Gimbutas on 8/22/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import UIKit
import RealmSwift

enum ExhangeType {
    case Sell
    case Buy
}

class MainViewController: BaseViewController {
    
    fileprivate var currencyConversionApiClient: CurrencyConversionApiClient
    fileprivate var holdingCurrencies = [Money]()
    
    var items = List<Account>()
    var realm: Realm!
    
    init(currencyConversionApiClient: CurrencyConversionApiClient) {
        self.currencyConversionApiClient = currencyConversionApiClient
        super.init()
    }
    
    override func getView() -> MainView {
        return self.view as! MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        holdingCurrencies = [Money(amountString: "0" , currency: "EUR"),
                             Money(amountString: "0", currency: "JPY"),
                             Money(amountString: "0", currency:  "USD")]
        getView().delegate = self
        setupRealm()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showCurrencyPicker(currency: String, exhangeType: ExhangeType) {
       
        let currenciesOptions = UIAlertController(title: nil, message: "Choose currency: ", preferredStyle: .actionSheet)
        
        for currency in holdingCurrencies {
            let currencyTitle = currency.currency
            currenciesOptions.addAction(UIAlertAction(title: currencyTitle, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                
                if exhangeType == .Sell {
                    self.getView().setSellingCurrency(currency: currencyTitle)
                } else if exhangeType == .Buy {
                    self.getView().setBuyingCurrency(currency: currencyTitle)
                }
            }))
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        currenciesOptions.addAction(cancelAction)
        self.present(currenciesOptions, animated: true, completion: nil)
    }
    
    func setupRealm() {
        
        

        DispatchQueue.main.async {
            let config = Realm.Configuration()
            self.realm = try! Realm(configuration: config)
            
            if self.items.realm == nil, let list = self.realm.objects(User.self).first {
                self.items = list.accounts
            }

            
//            for currency in self.holdingCurrencies {
//                
//            }
            
            
            
            print(self.items.count)
        }
    }

}


extension MainViewController: MainViewDelegate {
    
    func onSellCurrencyButtonClicked(fromMoney: Money, toCurrency: String) {
//        let _ =  currencyConversionApiClient
//            .calculate(fromAmount: fromMoney, toCurrency: toCurrency)
//            .continueWith { task in
//                if task.error != nil {
//                    Alerts.calculateRequestFailedAlert()
//                } else if let result = task.result {
//                    print("calculate: ", result.getAmount())
//                }
//                
//                
//            }
        try! self.items.realm?.write {
            self.items.insert(Account(value: ["amount": "00","currency": "EUR"]), at: self.items.filter("completed = false").count)
        }
    }
    func onBuyingCurrencySelectionClicked(currency: String) {
        self.showCurrencyPicker(currency: currency, exhangeType: .Buy)
    }
    func onSellingCurrencySelectionClicked(currency: String) {
        self.showCurrencyPicker(currency: currency, exhangeType: .Sell)
    }
}

