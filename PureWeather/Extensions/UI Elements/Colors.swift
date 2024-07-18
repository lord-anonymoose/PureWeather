//
//  Colors.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 10.07.2024.
//

import Foundation
import UIKit

extension UIColor {
    static var accentColor: UIColor {
        return UIColor(named: "AccentColor") ?? .systemBlue
    }
    
    static var snowflakeColor: UIColor {
        return UIColor(red: 0.482, green: 0.725, blue: 0.976, alpha: 0.2)
    }
    
    static var raindropColor: UIColor {
        return UIColor(red: 0.482, green: 0.725, blue: 0.976, alpha: 0.8)
    }
    
    static var cloudColor: UIColor {
        return UIColor(red: 0.933, green: 0.933, blue: 0.933, alpha: 1.0)
    }
    
    static var cloudDarkColor: UIColor {
        return UIColor.darkGray.withAlphaComponent(0.2)
    }
    
    static var windColor: UIColor {
        return UIColor.lightGray.withAlphaComponent(0.2)
    }
    
    static var sunColor: UIColor {
        return UIColor.yellow
    }
    
    static var thunderColor: UIColor {
        return UIColor.yellow
    }
    
    static var smokeColor: UIColor {
        return UIColor.black.withAlphaComponent(0.5)
    }
}
