//
//  FOLKExplorerViewController.swift
//  FOLKTesterApp
//
//  Created by James Folk on 2/2/22.
//

import UIKit

protocol FOLKHierarchyDelegate {
    func viewHierarchyDidDismiss(_ selectedView:UIView)
}

protocol FOLKExplorerViewControllerDelegate {
    func explorerViewControllerDidFinish(_ explorerViewController:FOLKExplorerViewController)
}

class FOLKExplorerViewController : UIViewController, FOLKHierarchyDelegate, UIAdaptivePresentationControllerDelegate {
    func viewHierarchyDidDismiss(_ selectedView: UIView) {
        
    }
    var delegate:FOLKExplorerViewControllerDelegate?
    private var viewsAtTapPoint: NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectionTap(_:))))
    }
    @objc private func handleSelectionTap(_ sender: UITapGestureRecognizer) {
        let tapPointInView = sender.location(in: self.view)
        let tapPointInWindow = self.view.convert(tapPointInView, to: nil)
        self.updateOutlineViewsForSelectionPoint(tapPointInWindow)
    }
    
    private func retrieveText(_ view:Any) -> String? {
        var ret: String?
        
        if let label = view as? UILabel {
            ret = label.text ?? ""
        } else if let textView = view as? UITextView {
            ret = textView.text
        } else if let textField = view as? UITextField {
            ret = textField.text ?? ""
        }
        return ret
    }
    
    private func reverseLookup(_ key: String) -> String {
        let val = FOLKManager.shared.crowdinKeyManager.get(key).joined(separator: ", ")
        if "" == val {
            return key
        }
        return val
    }
    
    private func updateOutlineViewsForSelectionPoint(_ selectionPointInWindow: CGPoint) {
        
        let views:NSArray = self.viewsAtPoint(selectionPointInWindow, false)
        
        let reversedViews : [Any] = Array(views.reversed())
        
        for view in reversedViews {
            if let text = retrieveText(view) {
                print(text)
                let alert = UIAlertController(title: "Alert", message: reverseLookup(text), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    switch action.style{
                        case .default:
                        print("default")
                        
                        case .cancel:
                        print("cancel")
                        
                        case .destructive:
                        print("destructive")
                        
                    @unknown default:
                        print("fatalError()")
                    }
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
    }
    
    private func viewsAtPoint(_ tapPointInWindow: CGPoint, _ skipHidden: Bool) -> NSArray {
        let views = NSMutableArray()
        
        FOLKUtility.appKeyWindow?.traverseHierarchy({responder, level in
            if case let window as UIWindow = responder {
                if(window != self.view.window && window.point(inside: tapPointInWindow, with: nil)) {
                    views.add(window)
                    views.addObjects(from: self.recursiveSubviewsAtPoint(tapPointInWindow, window, skipHidden) as! [Any])
                    
                }
            }

        })
        
        return views
    }
    
    private func recursiveSubviewsAtPoint(_ pointInView: CGPoint, _ view:UIView, _ skipHidden:Bool) -> NSArray {
        let subviewsAtPoint = NSMutableArray()
        for subview in view.subviews {
            let isHidden = subview.isHidden || subview.alpha < 0.01
            if skipHidden && isHidden {
                continue
            }
            
            let subviewContainsPoint = subview.frame.contains(pointInView)
            if subviewContainsPoint {
                subviewsAtPoint.add(subview);
            }
            
            if(subviewContainsPoint || !subview.clipsToBounds) {
                let pointInSubview = view.convert(pointInView, to: subview)
                subviewsAtPoint.addObjects(from: self.recursiveSubviewsAtPoint(pointInSubview, subview, skipHidden) as! [Any])
            }
            
        }
        return subviewsAtPoint
    }
    
}
