//
//  UIViewController+isRootViewControllerInNavigation.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/24/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation

extension UIViewController {
    func isRootViewControllerInNavigation() -> Bool {
        return self == self.navigationController?.viewControllers[0]
    }
}
