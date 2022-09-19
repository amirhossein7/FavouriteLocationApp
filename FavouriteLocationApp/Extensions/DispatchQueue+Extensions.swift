//
//  DispatchQueue+Extensions.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/15/22.
//

import Foundation


extension DispatchQueue {

    static func backgroundToMain(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
    
    static func backgroundThread(work: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).async {
            work()
        }
    }
    
    static func backgroundThread(delay: Double = 0.0, work: @escaping () -> ()) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime.now() + delay, execute: {
            work()
        })
    }
    
    static func mainThread(work: @escaping () -> ()) {
        DispatchQueue.main.async(execute: {
            work()
        })
    }
    
    static func mainThread(delay:Double = 0.0, work: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay , execute: {
            work()
        })
    }

}
