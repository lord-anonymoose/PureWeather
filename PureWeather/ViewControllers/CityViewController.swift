//
//  MainViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import UIKit
import WeatherKit
import CoreLocation

class CityViewController: UIViewController {
    
    var city: CLLocation? {
        didSet {
            if let location = self.city {
                Task {
                    let weatherRequest = await PureWeatherService.shared().getWeather(for: location)
                    if let weather = weatherRequest {
                        weatherView.updateSubviews(for: location, weather: weather)
                    }
                }
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
    init(city: CLLocation) {
        self.city = city
        super.init(nibName: nil, bundle: nil)
        Task {
            let weatherRequest = await PureWeatherService.shared().getWeather(for: city)
            if let weather = weatherRequest {
                weatherView.updateSubviews(for: city, weather: weather)
            }
        }
     }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    

    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(weatherView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            weatherView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 100),
            weatherView.heightAnchor.constraint(equalToConstant: 400),
            weatherView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            weatherView.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaGuide.leadingAnchor, constant: 25),
            weatherView.trailingAnchor.constraint(lessThanOrEqualTo: safeAreaGuide.trailingAnchor, constant: -25),
            weatherView.widthAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.width - 50)
        ])
    }
}

