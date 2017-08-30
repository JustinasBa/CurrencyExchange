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
    func onSellCurrencyButtonClicked(fromMoney: Money, toCurrency: String)
//    func onCurrencyLabelClicked(label: UILabel)
    func onSellingCurrencySelectionClicked(currency: String)
    func onBuyingCurrencySelectionClicked(currency: String)
}

class MainView: BaseSteviaView, UIGestureRecognizerDelegate {
    
    fileprivate let convertButton = UIButton()
    fileprivate let sellingCurrencyLabel = UILabel()
    fileprivate let buyingCurrencyLabel = UILabel()
    fileprivate let amountTextField = UITextField()
    fileprivate let separatorView = UIView()
    
    func getDelegate() -> MainViewDelegate? {
        return self.delegate as? MainViewDelegate
    }
    
    override func render() {
        super.render()
        backgroundColor = .white
        sv(
            convertButton.text("Convert").style(convertButtonStyle).tap(convertButtonTapped),
            sellingCurrencyLabel.text("EUR").style(currencyLabelStyle),
            buyingCurrencyLabel.text("EUR").style(currencyLabelStyle),
            amountTextField.placeholder("0.0").style(fieldStyle),
            separatorView.style(separatorViewStyle)
        )
        
        layout(
            200,
            alignHorizontally(|-16-sellingCurrencyLabel--amountTextField-16-|),
            10,
            alignHorizontally(|-separatorView.height(1)-|),
            10,
            alignHorizontally(|-16-buyingCurrencyLabel),
            100,
            |-16-convertButton-16-| ~ 60
        )
        
        let fromTapRecognizer = UITapGestureRecognizer(target: self, action:#selector(sellingCurrencySelectionTapGestureHandler(sender:)))
        fromTapRecognizer.delegate = self
        sellingCurrencyLabel.addGestureRecognizer(fromTapRecognizer)
        sellingCurrencyLabel.isUserInteractionEnabled = true
        
        let toTapRecognizer = UITapGestureRecognizer(target: self, action:#selector(buyingCurrencySelectionTapGestureHandler(sender:)))
        toTapRecognizer.delegate = self
        buyingCurrencyLabel.addGestureRecognizer(toTapRecognizer)
        buyingCurrencyLabel.isUserInteractionEnabled = true
    }
    
    //MARK - Setters Methods
    
    func setSellingCurrency(currency: String) {
        sellingCurrencyLabel.text = currency
    }
    func setBuyingCurrency(currency: String) {
        buyingCurrencyLabel.text = currency
    }
    
    //MARK - Actions
    
    private func convertButtonTapped() {
        guard let fromCurrency = self.buyingCurrencyLabel.text else { return }
        guard let fromAmount = self.amountTextField.text else { return }
        guard let toCurrency = self.buyingCurrencyLabel.text else { return }
        let money = Money(amountString: fromAmount, currency: fromCurrency)
        
        self.getDelegate()?.onSellCurrencyButtonClicked(fromMoney: money, toCurrency: toCurrency)
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
        button.backgroundColor = Themes.buttonColorGreen()
        button.layer.cornerRadius = button.frame.height / 2
    }
    
    private func currencyLabelStyle(label: UILabel) {
        label.font = UIFont(name: "HelveticaNeue-Light", size: 26)
    }
    
    private func separatorViewStyle(view: UIView) {
        view.backgroundColor = .gray
    }
    
    
    //MARK: - UITapGestureRecognizer
    
    @objc private func sellingCurrencySelectionTapGestureHandler(sender: UITapGestureRecognizer? = nil) {
        guard let text = buyingCurrencyLabel.text else { return }
        self.getDelegate()?.onSellingCurrencySelectionClicked(currency: text)
    }
    
    @objc private func buyingCurrencySelectionTapGestureHandler(sender: UITapGestureRecognizer? = nil) {
        guard let text = buyingCurrencyLabel.text else { return }
        self.getDelegate()?.onBuyingCurrencySelectionClicked(currency: text)
    }
    
}
