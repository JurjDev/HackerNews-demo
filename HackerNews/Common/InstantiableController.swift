//
//  InstantiableController.swift
//  HackerNews
//
//  Created by JurjDev on 17/04/21.
//

import Foundation
import UIKit

protocol InstantiableController: class {
    
    static func instance() -> Self
    static func navigationInstance() -> UINavigationController
}

extension InstantiableController where Self: UIViewController {
    
    static func navigationInstance() -> UINavigationController {
        let navigation = UINavigationController(rootViewController: self.instance())
        navigation.modalPresentationStyle = .fullScreen
        return navigation
    }
}
