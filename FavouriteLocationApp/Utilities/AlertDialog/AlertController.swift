//
//  AlertController.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import UIKit


class AlertController: NSObject {
    
    
    
    class func showAlertDialog(_ title:String = "", _ message: String = "", _ actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index:Int) -> Void) {
        
        if UIApplication.shared.applicationState == .active{
            
            if let alert = UIApplication.topViewController() as? UIAlertController {
                alert.dismiss(animated: true, completion: nil)
            }
            
            let alertController = UIAlertController(title: title, message: "\n\(message)", preferredStyle: UIAlertController.Style.alert)
            
            alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14) , NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")
            alertController.setValue(NSAttributedString(string: "\n\(message)", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14) , NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
            
            
            //  '_' equal index
            for (index , (title, style)) in actions.enumerated() {
                
                let alertAction = UIAlertAction(title: title, style: style) { (_) in
                    
                    completion(index)
                    
                }
                
                alertController.addAction(alertAction)
                if style == .default {
                    alertController.preferredAction = alertAction
                }
            }
            if let top = UIApplication.topViewController() {
                
                if let alert = alertController.popoverPresentationController {
                    alert.sourceView = top.view
                    alert.sourceRect = CGRect(x: top.view.bounds.midX, y: top.view.bounds.midY, width: 0, height: 0)
                    alert.permittedArrowDirections = []
                }
                
                top.present(alertController, animated: true, completion: nil)
            }
        }
                
    }
    
    
    class func showActionSheet(_ title: String?, _ message: String?, _ actions: [(String, UIAlertAction.Style)], completion: @escaping (_ index:Int) -> Void) {
        
        if UIApplication.shared.applicationState == .active{
            
            let actionSheetController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
            
            if title != nil {
                actionSheetController.setValue(NSAttributedString(string: title ?? "", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14) , NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedTitle")
            }
            
            if message != nil {
                actionSheetController.setValue(NSAttributedString(string: message ?? "", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14) , NSAttributedString.Key.foregroundColor : UIColor.black]), forKey: "attributedMessage")
            }
            
            
            
            //  '_' equal index
            for (index , (title, style)) in actions.enumerated() {
                
                let alertAction = UIAlertAction(title: title, style: style) { (_) in
                    
                    completion(index)
                    
                }
                
                actionSheetController.addAction(alertAction)
                
            }
            
            if let top = UIApplication.topViewController() {
                
                if let actionSheetController = actionSheetController.popoverPresentationController {
                    actionSheetController.sourceView = top.view
                    actionSheetController.sourceRect = CGRect(x: top.view.bounds.midX, y: top.view.bounds.midY, width: 0, height: 0)
                    actionSheetController.permittedArrowDirections = []
                }
                
                top.present(actionSheetController, animated: true, completion: nil)
            }
            
        }
       
    }
    

}




extension UIApplication {
    
    /// Returns the status bar UIView
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }

    
    class func topViewController
    (
        _ viewController: UIViewController? = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first?.rootViewController
    ) -> UIViewController?
    
    {
            
            
       if let nav = viewController as? UINavigationController {
           return topViewController(nav.visibleViewController)
       }
       if let tab = viewController as? UITabBarController {
           if let selected = tab.selectedViewController {
               return topViewController(selected)
           }
       }
       if let presented = viewController?.presentedViewController {
           return topViewController(presented)
       }
       
       return viewController
   }
       
    
}
