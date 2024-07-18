//
//  UIViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 18.07.2024.
//

import Foundation
import UIKit



extension UIViewController {
    func showAlert(message: String) {
        let title = String(localized: "Error!")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.view.tintColor = .accentColor
        self.present(alert, animated: true, completion: nil)
    }
}
