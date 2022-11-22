//
//  Log.swift
//  FavouriteLocationApp
//
//  Created by Amirhossein on 9/13/22.
//

import Foundation

public func Log<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        guard let object = object else { return }
        var log = String()
        log.append("──────────────────────   LOG   ──────────────────────\n")
        log.append("> \(filename.components(separatedBy: "/").last ?? "") -> \(funcname) -> (line: \(line)) :: (MainThread: \(Thread.current.isMainThread)) \n")
        log.append("\(object)\n")
        print(log)
    #endif
}
