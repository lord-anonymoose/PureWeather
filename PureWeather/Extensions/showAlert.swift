//
//  Alert.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 10.07.2024.
//

import UIKit


extension UIViewController {
    func showAlert(title: String, description: String, canCancel: Bool = false, handler: ((UIAlertAction) -> Void)? = nil) {
        let okButtonTitle = String(localized: "OK")
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: handler))

        if canCancel {
            let cancelButtonTitle = String(localized: "Cancel")
            alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel))
        }

        self.present(alert, animated: true)
    }
}
