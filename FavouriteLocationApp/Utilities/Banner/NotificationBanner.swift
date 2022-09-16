//
//  NotificationBanner.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/16/22.
//

import UIKit
import NotificationBannerSwift
import MarqueeLabel


open class EPBanner : NSObject {
    
    
    static var bannerDismiss: FloatingNotificationBanner? = nil

    
    open class func showBanner(_ message : String, _ style : BannerStyle, on viewController: UIViewController? = nil) {
        
        let banner = FloatingNotificationBanner(title: "", subtitle: message, style: style)
        banner.titleLabel?.textAlignment = .center
        banner.subtitleLabel?.textAlignment = .center
        banner.titleLabel?.font = EPFont.getFont(.regular, .middle)
        banner.subtitleLabel?.font = EPFont.getFont(.regular, .middle)
        
        if EPLocalize.isLeftAlignLocalize() {
            (banner.titleLabel as? MarqueeLabel)?.type = MarqueeLabel.MarqueeType.left
            //(banner.subtitleLabel)?.type = MarqueeLabel.MarqueeType.left
        }
        else{
            (banner.titleLabel as? MarqueeLabel)?.type = MarqueeLabel.MarqueeType.right
            //(banner.subtitleLabel)?.type = MarqueeLabel.MarqueeType.right
        }
        
        if message.length > 40{
            banner.duration = 6.0
        }else{
            banner.duration = 3.0
        }
        
        banner.show(queuePosition: QueuePosition.front, bannerPosition: BannerPosition.top, on: nil, cornerRadius: EPSizes.radius_big)
        
        
        banner.onTap = {
            Log("Banner Notification Tapped")
        }
        
        banner.onSwipeUp = {
            Log("Basic Notification Swiped Up")
        }
        
    }
    
    open class func showBanner(_ message : String, _ style : BannerStyle, on viewController: UIViewController? = nil, completion: @escaping () -> Void) {
        
        let banner = NotificationBanner(title: "try_again".EPLocalized(), subtitle: message, style: style)
        banner.titleLabel?.textAlignment = .center
        banner.subtitleLabel?.textAlignment = .center
        banner.titleLabel?.font = EPFont.getFont(.regular, .middle)
        banner.subtitleLabel?.font = EPFont.getFont(.regular, .middle)
        
        if EPLocalize.isLeftAlignLocalize() {
            (banner.titleLabel as? MarqueeLabel)?.type = MarqueeLabel.MarqueeType.left
            (banner.subtitleLabel)?.type = MarqueeLabel.MarqueeType.left
        }
        else{
            (banner.titleLabel as? MarqueeLabel)?.type = MarqueeLabel.MarqueeType.right
            (banner.subtitleLabel)?.type = MarqueeLabel.MarqueeType.right
        }
        
        banner.autoDismiss = false
        banner.show(queuePosition: QueuePosition.front, bannerPosition: BannerPosition.bottom, on: viewController)
        
        banner.onTap = {
            Log("Banner Notification Tapped")
            banner.dismiss()
            completion()
        }
        
        banner.onSwipeUp = {
            Log("Basic Notification Swiped Up")
        }
        
    }
    
    static func showBanner(message : String, withActionTitle actionTitle : String, _ style : BannerStyle, autoDismiss: Bool = true, on viewController: UIViewController? = nil, completion: @escaping () -> Void) {
        
        
        if let vc = viewController, let top = UIApplication.topViewController(), top !== vc{
            return
        }
        
        self.dismissBanner()
        
        
        let customBanner = BannerView()
        customBanner.messageLabel.text = message
        customBanner.tryButton.setTitle(actionTitle, for: .normal)
        
        // set background
        switch style {
            case .danger:
                customBanner.backgroundColor = EPColor.banner_error
            case .info:
                customBanner.backgroundColor = UIColor(red:0.23, green:0.60, blue:0.85, alpha:1.00)
            case .customView:
                customBanner.backgroundColor = EPColor.clear
            case .success:
                customBanner.backgroundColor = EPColor.success
            case .warning:
                customBanner.backgroundColor = EPColor.warning
        }
        
        let banner = FloatingNotificationBanner(customView: customBanner)
        //banner.bannerHeight = 80
        banner.autoDismiss = autoDismiss
        //banner.duration = 6.0
        banner.show(queuePosition: QueuePosition.front, bannerPosition: BannerPosition.bottom, on: viewController, cornerRadius: EPValues.radius_double_big)
          
        customBanner.tryButton.action { (_) in
            Log("Banner Notification Action")
            banner.dismiss()
            completion()
        }
        
        banner.onTap = {
            Log("Banner Notification Tapped")
            banner.dismiss()
            completion()
        }
        
        banner.onSwipeUp = {
            Log("Basic Notification Swiped Up")
        }
        self.bannerDismiss = banner
    }
    
    static func dismissBanner(){
        self.bannerDismiss?.dismiss()
      }
    
    
    open class func showBannerInternet(){
        
        let message = "no_internet_connection_msg".EPLocalized()
        let banner = FloatingNotificationBanner(title: "", subtitle: message, style: .warning)
        banner.titleLabel?.textAlignment = .center
        banner.subtitleLabel?.textAlignment = .center
        banner.titleLabel?.font = EPFont.getFont(.regular, .middle)
        banner.subtitleLabel?.font = EPFont.getFont(.regular, .middle)
        
        if EPLocalize.isLeftAlignLocalize() {
            (banner.titleLabel as? MarqueeLabel)?.type = MarqueeLabel.MarqueeType.left
            //(banner.subtitleLabel)?.type = MarqueeLabel.MarqueeType.left
        }
        else{
            (banner.titleLabel as? MarqueeLabel)?.type = MarqueeLabel.MarqueeType.right
            //(banner.subtitleLabel)?.type = MarqueeLabel.MarqueeType.right
        }
        
        if message.length > 40{
            banner.duration = 6.0
        }else{
            banner.duration = 3.0
        }
        
        banner.show(queuePosition: QueuePosition.front, bannerPosition: BannerPosition.top, on: nil, cornerRadius: EPSizes.radius_big)
        
        
        banner.onTap = {
            Log("Banner Notification Tapped")
        }
        
        banner.onSwipeUp = {
            Log("Basic Notification Swiped Up")
        }
    }
    
}
