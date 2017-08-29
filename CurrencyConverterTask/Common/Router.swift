//
//  Router.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/24/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation

class Router: NSObject {
    func goToViewController(_ controller: UIViewController) {
        if UIViewController().topmostController().navigationController != nil || UIViewController().topmostController() is UINavigationController {
            UIViewController().topmostController().show(controller, sender: nil)
        } else {
            goToViewControllerInNavigationViewController(controller)
        }
    }
    
    func goToViewControllerInNavigationViewController(_ controller: UIViewController) {
        UIViewController().topmostController().presentViewControllerInNavigationViewController(controller)
    }
    
    func goToViewControllerWithoutNavigationViewController(controller: UIViewController) {
        UIViewController().topmostController().present(controller, animated: true, completion: nil)
    }
}
