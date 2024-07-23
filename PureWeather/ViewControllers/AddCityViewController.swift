//
//  AddCityViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 18.07.2024.
//

import Foundation
import UIKit
import MapKit



class AddCityViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var pinIsShown: Bool = false {
        didSet {
            if pinIsShown {
                self.textField.isEnabled = false
                let configuration = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
                let image = UIImage(systemName: "mappin.slash.circle.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal).applyingSymbolConfiguration(configuration)
                showPinButton.setImage(image, for: .normal)
                pinImageView.isHidden = false
            } else {
                self.textField.isEnabled = true
                let configuration = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
                let image = UIImage(systemName: "mappin.circle.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal).applyingSymbolConfiguration(configuration)
                showPinButton.setImage(image, for: .normal)
                pinImageView.isHidden = true
            }
        }
    }
    
    private var notificationLabelBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Subviews
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var notificationLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .secondarySystemFill
        label.textAlignment = .center
        label.layer.cornerRadius = 15.0
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textField: UITextFieldWithPadding = {
        let textField = UITextFieldWithPadding()
        textField.placeholder = String(localized: "City name...")
        textField.backgroundColor = .secondarySystemFill
        textField.layer.cornerRadius = 10.0
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var showPinButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        let image = UIImage(systemName: "mappin.circle.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal).applyingSymbolConfiguration(configuration)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 25
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(showPinButtonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var pinImageView: UIImageView = {
        let sizeConfiguration = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
        let colorConfiguration = UIImage.SymbolConfiguration(paletteColors: [.systemRed, .systemBlue])
        let image = UIImage(systemName: "mappin.and.ellipse")?.applyingSymbolConfiguration(sizeConfiguration)?.applyingSymbolConfiguration(colorConfiguration)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isHidden = true
        return imageView
    }()
    
    private lazy var saveLocationButton: UIButton = {
        let button = UIButton()
        let title = String(localized: "Save Location")
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 10.0
        button.backgroundColor = .accentColor
        button.addTarget(self, action: #selector(saveLocationButtonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    
    // MARK: - Actions
    
    @objc func saveLocationButtonTapped(_ button: UIButton) {
        getLocation(from: textField.text ?? "") { location in
            if let location = location {
                StorageService.shared().postLocation(location: location)
                let text = String(localized: "Location saved")
                self.showNotificationLabel(text: text)
                self.mapView.centerMapOnLocation(location)
                self.mapView.addAnnotationAtLocation(location)
                print("location posted")
            } else {
                let title = String(localized: "Error!")
                let description = String(localized: "Could not find a city with a name you have provided!")
                self.showAlert(title: title, description: description)
            }
        }
    }
    
    @objc func showPinButtonTapped(_ button: UIButton) {
        self.pinIsShown.toggle()
        print("showPinButtonTapped")
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    
    
    // MARK: - Private
    private func setupDelegates() {
        mapView.delegate = self
        textField.delegate = self
        locationManager.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        mapView.showsUserLocation = true
        
        let status = locationManager.authorizationStatus

        switch status {
        case .notDetermined:
            print("notDetermined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            getLocation(from: "Cupertino") {location in
                if let location = location {
                    self.mapView.centerMapOnLocation(location)
                    self.mapView.addAnnotationAtLocation(location)
                }
            }
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        @unknown default:
            fatalError("Unhandled case in CLLocationManager.authorizationStatus()")
        }
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mapView)
        mapView.addSubview(showPinButton)
        mapView.addSubview(pinImageView)
        scrollView.addSubview(textField)
        scrollView.addSubview(saveLocationButton)
        view.addSubview(notificationLabel)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        let mapHeight = safeAreaGuide.layoutFrame.height * 2 / 3
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            mapView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mapView.heightAnchor.constraint(equalToConstant: mapHeight),
        ])
        
        NSLayoutConstraint.activate([
            showPinButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -10),
            showPinButton.heightAnchor.constraint(equalToConstant: 50),
            showPinButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
            showPinButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            pinImageView.bottomAnchor.constraint(equalTo: mapView.centerYAnchor),
            pinImageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            pinImageView.heightAnchor.constraint(equalToConstant: 50),
            pinImageView.widthAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 25),
            textField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            textField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25),
            textField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            saveLocationButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 25),
            saveLocationButton.heightAnchor.constraint(equalToConstant: 50),
            saveLocationButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            saveLocationButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25),
            saveLocationButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        notificationLabelBottomConstraint = notificationLabel.bottomAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: -100)
        
        notificationLabelBottomConstraint.isActive = true
        NSLayoutConstraint.activate([
            notificationLabel.heightAnchor.constraint(equalToConstant: 35),
            notificationLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            notificationLabel.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func showNotificationLabel(text: String = "") {
        notificationLabel.isHidden = false
        notificationLabelBottomConstraint.constant = 0
        notificationLabel.text = text
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
            self.notificationLabel.layer.cornerRadius = 10.0
        }) { _ in
            UIView.animate(withDuration: 1, delay: 2, animations: {
                self.notificationLabel.alpha = 0
            }, completion: { _ in
                self.notificationLabel.isHidden = true
                self.notificationLabel.alpha = 1
                self.notificationLabelBottomConstraint.constant = -100
                self.view.layoutIfNeeded()
            })
        }
    }
}



extension AddCityViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if pinIsShown {
            let centerCoordinate = mapView.centerCoordinate
            let centerLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
            
            centerLocation.getCityName { cityName in
                if let location = cityName {
                    self.textField.text = location
                } else {
                    self.textField.text = ""
                }
            }
        }
    }
}



extension AddCityViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        getLocation(from: textField.text ?? "") { location in
            if let location = location {
                print("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                self.mapView.centerMapOnLocation(location)
                self.mapView.addAnnotationAtLocation(location)
            } else {
                let title = String(localized: "Error!")
                let description = String(localized: "Could not find a city with a name you have provided!")
                self.showAlert(title: title, description: description)
            }
        }
        
        return true
    }
}



extension AddCityViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            mapView.centerMapOnLocation(location)
            location.getCityName { cityName in
                if let location = cityName {
                    self.textField.text = location
                } else {
                    self.textField.text = ""
                }
            }
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
