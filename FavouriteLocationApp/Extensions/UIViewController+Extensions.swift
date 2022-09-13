//
//  UIViewController+Extensions.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit

extension UIViewController {
    
    func add(child: UIViewController, in view: UIView) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    /*
    func removeChildController(){
        guard let parent = parent as? MainController else {
            return
        }
        parent.remove(child: self)
    }
    */
    func containsChildViewController(ofKind kind: AnyClass) -> Bool {
        return self.children.contains(where: { $0.isKind(of: kind) })
    }
    
    func getChildViewController(ofKind kind: AnyClass) -> UIViewController? {
        return self.children.first(where: { $0.isKind(of: kind) })
    }
    
    func removeAllChildController(){
        if self.children.count > 0 {
            self.children.enumerated().forEach { (offset, element) in
                element.remove()
            }
        }
    }
}
