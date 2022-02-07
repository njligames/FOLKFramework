//
//  FOLKManager.swift
//  FOLKTesterApp
//
//  Created by James Folk on 2/2/22.
//

import UIKit

public class FOLKManager : FOLKExplorerViewControllerDelegate, FOLKWindowEventDelegate {
    func shouldHandleTouchAtPoint(_ pointInWindow: CGPoint) -> Bool {
        return true
    }
    
    internal func canBecomeKeyWindow() -> Bool {
        return true
    }
    
    internal func explorerViewControllerDidFinish(_ explorerViewController: FOLKExplorerViewController) {
        
    }
    private var folkExplorerWindow: FOLKWindow?
    private var folkExplorerViewController: FOLKExplorerViewController?
    
    public var crowdinKeyManager: CrowdInKeyManager = CrowdInKeyManager()
    
    public static let shared = FOLKManager()
    
    private init(){}
    
    private func explorerViewController() -> FOLKExplorerViewController {
        if(self.folkExplorerViewController == nil) {
            self.folkExplorerViewController = FOLKExplorerViewController();
            self.folkExplorerViewController!.delegate = self
        }
        return self.folkExplorerViewController!
    }
    
    public func showExplorer() {
        let folk = self.explorerWindow();
        folk.isHidden = false
        
        guard #available(iOS 13, *) else {
            return
        }
        
        if nil == folk.windowScene {
            folk.windowScene = FOLKUtility.appKeyWindow!.windowScene;
        }
    }
    
    public func hideExplorer() {
        let folk = self.explorerWindow();
        folk.isHidden = true
    }
    
    public func toggleExplorer() -> Bool {
        let folk = self.explorerWindow();
        if folk.isHidden {
            if #available(iOS 13, *) {
                self.showExplorerFromScene(FOLKUtility.appKeyWindow!.windowScene!)
            } else {
                self.showExplorer()
            }
        } else {
            self.hideExplorer()
        }
        return folk.isHidden
    }
    
    @available(iOS 13.0, *)
    public func showExplorerFromScene(_ scene:UIWindowScene) {
        let folk = self.explorerWindow();
        folk.windowScene = scene
        folk.isHidden = false
        
    }
    
    private func explorerWindow() -> FOLKWindow {
        assert(Thread.isMainThread, "You must use \(NSStringFromClass(type(of: self))) from the main thread only.")
        
        if nil == folkExplorerWindow {
            
            let w : FOLKWindow = FOLKWindow.init(frame: FOLKUtility.appKeyWindow!.bounds)
            w.eventDelegate = self
            w.rootViewController = self.explorerViewController()
            
            folkExplorerWindow = w
        }
        return folkExplorerWindow!
    }
}

