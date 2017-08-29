//
//  BaseSteviaView.swift
//  Paysera
//
//  Created by Arvydas Dudavicius on 26/01/2017.
//  Copyright © 2017 Lemon Labs. All rights reserved.
//

import Foundation

protocol BaseSteviaViewDelegate: class {
    
}

class BaseSteviaView: UIView {
    weak var delegate: BaseSteviaViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        (TyphoonComponentFactory.defaultFactory() as AnyObject).inject(self)
        render()
        self.onViewInitialized()
    }
    
    func render() {
    }
    
    func onViewInitialized() {
    }
    
    func viewDidAppear(animated: Bool) {
    }
    
    func viewWillAppear(animated: Bool) {
    }
    
    func getDelegate() -> BaseSteviaViewDelegate? {
        return self.delegate
    }
    
    override func awakeAfter(using aDecoder: NSCoder) -> Any? {
        (TyphoonComponentFactory.defaultFactory() as AnyObject).inject(self)
        return self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        render()
        self.onViewInitialized()
    }
}
