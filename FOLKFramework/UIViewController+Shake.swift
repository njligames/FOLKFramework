//
//  UIViewController+Shake.swift
//  FOLKFramework
//
//  Created by James Folk on 2/5/22.
//

import UIKit

extension UIViewController {
    // Enable detection of shake motion
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            var text = "FOLK View Explorer is ON"
            if FOLKManager.shared.toggleExplorer() {
                text = "FOLK View Explorer is OFF"
            }
            self.showToast(message: text, font: .systemFont(ofSize: 12.0))
        }
    }
}
