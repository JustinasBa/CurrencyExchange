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
    func onConvertionButtonClicked(fromMoney: Money, toCurrency: String)
}

class MainView: BaseSteviaView, UIGestureRecognizerDelegate {
    let convertButton = UIButton()
    let fromCurrencyLabel = UILabel()
    let toCurrencyLabel = UILabel()
    let amountTextField = UITextField()
    let separatorView = UIView()
    
    private var currentChandedLabel: Int?
    
    func getDelegate() -> MainViewDelegate? {
        return self.delegate as? MainViewDelegate
    }
    
    override func render() {
        super.render()
        backgroundColor = .white
        sv(
            convertButton.text("Convert").style(convertButtonStyle).tap(convertButtonTapped),
            fromCurrencyLabel.text("EUR").style(currencyLabelStyle),
            toCurrencyLabel.text("EUR").style(currencyLabelStyle),
            amountTextField.placeholder("0.0").style(fieldStyle),
            separatorView.style(separatorViewStyle)
        )
        
        layout(
            200,
            alignHorizontally(|-16-fromCurrencyLabel--amountTextField-16-|),
            10,
            alignHorizontally(|-separatorView.height(1)-|),
            10,
            alignHorizontally(|-16-toCurrencyLabel),
            100,
            |-16-convertButton-16-| ~ 60
        )

        let fromTapRecognizer = UITapGestureRecognizer(target: self, action:#selector(fromTapGestureHandler(sender:)))
        fromTapRecognizer.delegate = self
        fromCurrencyLabel.addGestureRecognizer(fromTapRecognizer)
        fromCurrencyLabel.isUserInteractionEnabled = true
        
        let toTapRecognizer = UITapGestureRecognizer(target: self, action:#selector(toTapGestureHandler(sender:)))
        toTapRecognizer.delegate = self
        toCurrencyLabel.addGestureRecognizer(toTapRecognizer)
        toCurrencyLabel.isUserInteractionEnabled = true
    }
    
//MARK - Actions
    
    private func convertButtonTapped() {
        guard let fromCurrency = self.fromCurrencyLabel.text else { return }
        guard let fromAmount = self.amountTextField.text else { return }
        guard let toCurrency = self.toCurrencyLabel.text else { return }
        let money = Money(amountString: fromAmount, currency: fromCurrency)
        
        self.getDelegate()?.onConvertionButtonClicked(fromMoney: money, toCurrency: toCurrency)
    }
    
//MARK: - Style
    
    private func fieldStyle(field: UITextField) {
        field.borderStyle = .roundedRect
        field.font = UIFont(name: "HelveticaNeue-Light", size: 26)
        field.returnKeyType = .next
        field.keyboardType = .numberPad
        field.makeTextWritingDirectionRightToLeft(field)
    }
    
    private func convertButtonStyle(button: UIButton) {
        button.backgroundColor = kColorGreen
        button.layer.cornerRadius = button.frame.height / 2
    }
    
    private func currencyLabelStyle(label: UILabel) {
        label.font = UIFont(name: "HelveticaNeue-Light", size: 26)
    }
    
    private func separatorViewStyle(view: UIView) {
        view.backgroundColor = .gray
    }
    
    
//MARK: - UITapGestureRecognizer
    
    func fromTapGestureHandler(sender: UITapGestureRecognizer? = nil) {
        showCurrencyPicker(label: fromCurrencyLabel)
    }
    
    func toTapGestureHandler(sender: UITapGestureRecognizer? = nil) {
        showCurrencyPicker(label: toCurrencyLabel)
    }
    
    func showCurrencyPicker(label: UILabel) {
        
        let holdingCurrencies = ["EUR","USD","JPY"]
        let currenciesOptions = UIAlertController(title: nil, message: "Choose currency: ", preferredStyle: .actionSheet)
        
        for module in 0..<holdingCurrencies.count {
            let currency = holdingCurrencies[module]
            
            currenciesOptions.addAction(UIAlertAction(title: currency, style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                label.text = holdingCurrencies[module]
            }))
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        currenciesOptions.addAction(cancelAction)
        let topView = self.window?.rootViewController
        topView?.present(currenciesOptions, animated: true, completion: nil)
    }
}
