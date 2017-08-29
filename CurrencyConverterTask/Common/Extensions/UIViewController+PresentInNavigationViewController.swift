//
//  UIViewController+PresentInNavigationViewController.swift
//  CurrencyConverterTask
//
//  Created by Justinas Baronas on 8/24/17.
//  Copyright © 2017 Vytautas Gimbutas. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func presentViewControllerInNavigationViewControllerForObjectiveC(_ controller: UIViewController, completion: @escaping ((Void) -> (Void)) = {}) {
        self.present(
            UINavigationController.init(rootViewController: controller),
            animated: true,
            completion: {
                completion()
        }
        )
    }
    
    func presentViewControllerInNavigationViewController(_ controller: UIViewController,
                                                         modalPresentationStyle: UIModalPresentationStyle? = nil,
                                                         modalTransitionStyle: UIModalTransitionStyle? = nil,
                                                         completion: @escaping ((Void) -> (Void)) = {}) {
        let controller = UINavigationController.init(rootViewController: controller)
        if let modalPresentationStyle = modalPresentationStyle {
            controller.modalPresentationStyle = modalPresentationStyle
            
        }
        if let modalTransitionStyle = modalTransitionStyle {
            controller.modalTransitionStyle = modalTransitionStyle
        }
        self.present(
            controller,
            animated: true,
            completion: {
                completion()
        }
        )
    }
}
