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
    func onConvertionButtonClicked()
}

class MainView: BaseSteviaView {
    
    override func render() {
        super.render()
        backgroundColor = .white
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated: animated)
        self.getDelegate()?.onConvertionButtonClicked()
    }
    
    
    func buttonTapped() {
        self.getDelegate()?.onConvertionButtonClicked()
    }
    
    func getDelegate() -> MainViewDelegate? {
        return self.delegate as? MainViewDelegate
    }

}
