//
//  Extensions.swift
//  DemoApp
//
//  Created by Abhas on 22/06/21.
//  Copyright © 2021 Abhas. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setNavigationBarTitle(title: String) {
        navigationItem.title = title
        let textAttributes = [NSAttributedString.Key.foregroundColor : UIColor.darkGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.tintColor = AppDelegate.themeColor
    }
}

extension UIButton {
    
    struct associatedType {
        static var isSectionCollapsed: Bool?
    }
    
    var isSectionCollapsed: Bool? {
        get {
            return objc_getAssociatedObject(self, &associatedType.isSectionCollapsed) as? Bool
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &associatedType.isSectionCollapsed, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
