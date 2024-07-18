//
//  WeatherView.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 16.07.2024.
//

import WeatherKit
import UIKit
import MapKit



class WeatherView: UIView {
    
    // MARK: - Subviews
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .secondaryTitleFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.image = defaultImage
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .titleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.font = .secondaryTitleFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    // MARK: - Lifecycle
    init(frame: CGRect, weather: Weather) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
        updateSubviews(weather: weather)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - Private
    private func addSubviews() {
        addSubview(cityLabel)
        addSubview(imageView)
        addSubview(conditionLabel)
        addSubview(temperatureLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor),
            cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 25),
            conditionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            conditionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func updateSubviews(weather: Weather) {
        imageView.image = weather.currentWeather.condition.image
        conditionLabel.text = weather.currentWeather.condition.localizedString
        temperatureLabel.text = weather.currentWeather.temperature.value.formattedTemperatureCelcius()
    }
    
    func updateSubviews(for city: CLLocation, weather: Weather) {
        city.getCityName { cityName in
            if let location = cityName {
                self.cityLabel.text = location
            } else {
                print("City not found")
            }
            self.imageView.image = weather.currentWeather.condition.image
            self.conditionLabel.text = weather.currentWeather.condition.localizedString
            self.temperatureLabel.text = weather.currentWeather.temperature.value.formattedTemperatureCelcius()
        }
    }
}
