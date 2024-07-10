//
//  PrivacyViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import UIKit
import CoreLocation

class PrivacyViewController: UIViewController {
    
    var locationManager: CLLocationManager?
    
    
    // MARK: - Private
    private lazy var privacyImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "hand.raised.circle")
        imageView.image = image?.withTintColor(.accentColor)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var privacyLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "We truly care about your privacy! That is why our app is built using Apple WeatherKit framework - which never stoles or sells your data. Moreover, PureWeather app is open-source and you can always find its source code on GitHub.\n\nYour location is used to provide you weather data. If you do not want to share your location, you can add cities manually.")
        label.font = .labelFont
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var allowLocationButton: CustomButton = {
        let button = CustomButton()
        let text = String(localized: "Allow location access")
        button.setTitle(text, for: .normal)
        button.setBackgroundColor(.accentColor, forState: .normal)
        button.setBackgroundColor(.accentColor.withAlphaComponent(0.3), forState: .highlighted)
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(allowLocationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var declineLocationButton: CustomButton = {
        let button = CustomButton()
        let text = String(localized: "Choose location manually")
        button.setTitle(text, for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.setBackgroundColor(.systemFill, forState: .normal)
        button.setBackgroundColor(.systemFill.withAlphaComponent(0.3), forState: .highlighted)
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(declineLocationButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    
    // MARK: - Actions
    @objc func allowLocationButtonTapped(_ button: UIButton) {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        AppService.shared().setLaunched()
    }
    
    @objc func declineLocationButtonTapped(_ button: UIButton) {
        let alertTitle = String(localized: "Notice", comment: "Alert title when declining location access")
        let alertDescription = String(localized: "You will not be able to set location automatically. It can be changed later in settings.")
        let cancelButtonTitle = String(localized: "Cancel")
        let okButtonTitle = String(localized: "OK")
        let alert = UIAlertController(title: alertTitle, message: alertDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel))
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }))
        self.present(alert, animated: true)
    }
    
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(privacyImageView)
        scrollView.addSubview(privacyLabel)
        scrollView.addSubview(allowLocationButton)
        scrollView.addSubview(declineLocationButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        let contentLayoutGuide = scrollView.contentLayoutGuide
        let frameLayoutGuide = scrollView.frameLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            privacyImageView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: 25),
            privacyImageView.heightAnchor.constraint(equalToConstant: 100),
            privacyImageView.centerXAnchor.constraint(equalTo: frameLayoutGuide.centerXAnchor),
            privacyImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            privacyLabel.topAnchor.constraint(equalTo: privacyImageView.bottomAnchor, constant: 25),
            privacyLabel.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor, constant: 25),
            privacyLabel.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor, constant: -25),
        ])
        
        NSLayoutConstraint.activate([
            allowLocationButton.topAnchor.constraint(equalTo: privacyLabel.bottomAnchor, constant: 25),
            allowLocationButton.heightAnchor.constraint(equalToConstant: 50),
            allowLocationButton.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor, constant: 25),
            allowLocationButton.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor, constant: -25),
        ])
        
        NSLayoutConstraint.activate([
            declineLocationButton.topAnchor.constraint(equalTo: allowLocationButton.bottomAnchor, constant: 15),
            declineLocationButton.heightAnchor.constraint(equalToConstant: 50),
            declineLocationButton.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor, constant: 25),
            declineLocationButton.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor, constant: -25),
            declineLocationButton.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -50)
        ])
    }
}


extension PrivacyViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            print("Location access granted")
            handleLocationAccessGranted()
        case .denied, .restricted:
            print("Location access denied or restricted")
            handleLocationAccessDenied()
        case .notDetermined:
            print("Location access not determined yet")
        @unknown default:
            print("Unknown authorization status")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Updated location: \(location)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location: \(error)")
    }
    
    private func handleLocationAccessGranted() {
        locationManager?.startUpdatingLocation()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func handleLocationAccessDenied() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
