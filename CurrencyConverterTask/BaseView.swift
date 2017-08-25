//
//  BaseView.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/24/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import UIKit

protocol BaseViewDelegate: class {
    
}

class BaseView: UIView, BaseViewDelegate {
    var view: UIView!
    
    weak var delegate: BaseViewDelegate?
    
    fileprivate func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        layoutIfNeeded()
    }
    
    fileprivate func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.getXibName(), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
        
    }
    
    func getXibName() -> String {
        return String(describing: self.classForCoder)
    }
    
    func onViewInitialized() {
    }
    
    func viewDidAppear(animated: Bool) {
    }
    
    func viewWillAppear(animated: Bool) {
    }
    
    func getDelegate() -> BaseViewDelegate? {
        return self.delegate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        self.onViewInitialized()
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        (TyphoonComponentFactory.defaultFactory() as AnyObject).inject(self)
        return self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        self.onViewInitialized()
    }
}

