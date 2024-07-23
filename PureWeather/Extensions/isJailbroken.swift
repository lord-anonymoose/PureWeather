//
//  isJailbroken.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 18.07.2024.
//

import Foundation
import UIKit



func isJailbroken() -> Bool {
    if let urlScheme = NSURL(string: "cydia://"),
       UIApplication.shared.canOpenURL(urlScheme as URL) {
        return true
    }
    do {
        try "text".data(using: .utf8)?.write(to: URL(filePath: "/test.txt"))
        return true
    } catch {
        
    }
    return false
}
