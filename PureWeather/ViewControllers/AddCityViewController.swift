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
                let configuration = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
                let image = UIImage(systemName: "mappin.slash.circle.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal).applyingSymbolConfiguration(configuration)
                showPinButton.setImage(image, for: .normal)
                pinImageView.isHidden = false
            } else {
                let configuration = UIImage.SymbolConfiguration(pointSize: 50, weight: .bold, scale: .large)
                let image = UIImage(systemName: "mappin.circle.fill")?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal).applyingSymbolConfiguration(configuration)
                showPinButton.setImage(image, for: .normal)
                pinImageView.isHidden = true
            }
        }
    }
    
    // MARK: - Subviews
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .green
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var textField: UITextFieldWithPadding = {
        let textField = UITextFieldWithPadding()
        textField.placeholder = String(localized: "City name...")
        textField.backgroundColor = .white
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
    
    private lazy var showLocationButton: UIButton = {
        let button = UIButton()
        let title = String(localized: "Show location")
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 10.0
        button.backgroundColor = .accentColor
        button.addTarget(self, action: #selector(showLocationButtonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        setupUI()
        addSubviews()
        setupConstraints()
        mapView.delegate = self
    }
    
    
    // MARK: - Actions
    @objc func showLocationButtonTapped(_ button: UIButton) {
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
    }
    
    @objc func saveLocationButtonTapped(_ button: UIButton) {
        getLocation(from: textField.text ?? "") { location in
            if let location = location {
                StorageService.shared().postLocation(location: location)
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

    
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .yellow
        mapView.showsUserLocation = true
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mapView)
        mapView.addSubview(showPinButton)
        mapView.addSubview(pinImageView)
        scrollView.addSubview(textField)
        scrollView.addSubview(showLocationButton)
        scrollView.addSubview(saveLocationButton)
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
            showLocationButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 25),
            showLocationButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 25),
            showLocationButton.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -12.5),
            showLocationButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            saveLocationButton.topAnchor.constraint(equalTo: showLocationButton.topAnchor),
            saveLocationButton.bottomAnchor.constraint(equalTo: showLocationButton.bottomAnchor),
            saveLocationButton.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 12.5),
            saveLocationButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -25),
            saveLocationButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}

extension AddCityViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if pinIsShown {
            let center = mapView.centerCoordinate
            
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
