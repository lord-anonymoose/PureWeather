//
//  Alert.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 10.07.2024.
//

import UIKit


extension UIViewController {
    private func showErrorAlert(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
