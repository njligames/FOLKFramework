//
//  FOLKUtility.swift
//  FOLKTesterApp
//
//  Created by James Folk on 2/3/22.
//

import UIKit

enum FOLKUtility {
    static var appKeyWindow: UIWindow? {
        if let window = UIApplication.shared.keyWindow {
            if let folkwindow = window as? FOLKWindow {
                return folkwindow.previousKeyWindow
            }
            return window
        }
        
        for window in UIApplication.shared.windows {
            if window.isKeyWindow {
                if let folkwindow = window as? FOLKWindow {
                    return folkwindow.previousKeyWindow
                }
                return window
            }
        }
        
        return nil
    }
}
