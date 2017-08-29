//
//  MainView.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/24/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation
import Stevia

protocol MainViewDelegate: BaseSteviaViewDelegate {
    func onSellCurrencyButtonClicked(fromCurrency currency: String, amount: String)
}

class MainView: BaseSteviaView {
    
    override func render() {
        super.render()
        backgroundColor = .white
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated: animated)
    }
    
    
    func buttonTapped() {
        self.getDelegate()?.onSellCurrencyButtonClicked(fromCurrency: "EUR", amount: "20")
    }
    
    func getDelegate() -> MainViewDelegate? {
        return self.delegate as? MainViewDelegate
    }

}
