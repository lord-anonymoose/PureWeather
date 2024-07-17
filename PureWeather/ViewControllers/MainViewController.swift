//
//  MainViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import UIKit
import WeatherKit
import CoreLocation

class MainViewController: UIViewController {
    
    
    var weather: Weather? {
        didSet {
            if let newWeather = self.weather {
                weatherView.updateSubviews(weather: newWeather)
                print("Has weather")
            } else {
                print("No weather")
            }
        }
    }
    
    // MARK: - Subviews
    private lazy var weatherView: WeatherView = {
        let view = WeatherView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addSubviews()
        setupConstraints()
        setupNavigationBar()
        
        Task {
            self.weather = await PureWeatherService.shared().getWeather()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        setupNavigationBar()
        
    }
    
    // MARK: - Actions
    @objc func settingsButtonTapped(_ button: UIButton) {
        let settingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func updateSubviews() {
        self.weatherView.imageView.image = self.weather?.currentWeather.condition.image
        self.weatherView.conditionLabel.text = self.weather?.currentWeather.condition.localizedString
        if let temp = self.weather?.currentWeather.temperature.value {
            self.weatherView.temperatureLabel.text = temp.formattedTemperatureFahrenheit()
        }        
    }
    
    private func addSubviews() {
        view.addSubview(weatherView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            weatherView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            weatherView.heightAnchor.constraint(equalToConstant: 400),
            weatherView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            weatherView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            weatherView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25)
        ])
    }
    
    private func setupNavigationBar() {
        let settingsImage = UIImage(systemName: "gear")
        let settingsButton = UIBarButtonItem(image: settingsImage, style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = settingsButton
    }
}

