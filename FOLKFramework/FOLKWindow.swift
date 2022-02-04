//
//  FOLKWindow.swift
//  FOLKTesterApp
//
//  Created by James Folk on 2/3/22.
//

import UIKit

protocol FOLKWindowEventDelegate {
    func shouldHandleTouchAtPoint(_ pointInWindow: CGPoint) -> Bool
    func canBecomeKeyWindow() -> Bool
}

class FOLKWindow : UIWindow {
    public var eventDelegate: FOLKWindowEventDelegate?
    public var previousKeyWindow: UIWindow?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.windowLevel = UIWindow.Level.statusBar + 100.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let delegate = self.eventDelegate else {
            return false
        }
        
        var pointInside = false
        if delegate.shouldHandleTouchAtPoint(point) {
            pointInside = super.point(inside: point, with: event)
        }
        return pointInside
        
    }
    
    private func shouldAffectStatusBarAppearance() ->Bool{
        return self.isKeyWindow
    }
    
    func canBecomeKeyWindow() -> Bool {
        guard let delegate = self.eventDelegate else {
            return false
        }
        return delegate.canBecomeKeyWindow()
    }
    
    override func makeKey() {
        previousKeyWindow = FOLKUtility.appKeyWindow
        super.makeKey()
    }
    
    override func resignKey() {
        super.resignKey()
        previousKeyWindow = nil
    }
}
