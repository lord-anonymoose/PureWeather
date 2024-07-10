//
//  PrivacyViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import UIKit

class PrivacyViewController: UIViewController {
    
    
    
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
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    
    // MARK: - Actions
    
    
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(privacyImageView)
        scrollView.addSubview(privacyLabel)
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
            privacyImageView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor, constant: 50),
            privacyImageView.heightAnchor.constraint(equalToConstant: 100),
            privacyImageView.centerXAnchor.constraint(equalTo: frameLayoutGuide.centerXAnchor),
            privacyImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            privacyLabel.topAnchor.constraint(equalTo: privacyImageView.bottomAnchor, constant: 50),
            privacyLabel.leadingAnchor.constraint(equalTo: frameLayoutGuide.leadingAnchor, constant: 25),
            privacyLabel.trailingAnchor.constraint(equalTo: frameLayoutGuide.trailingAnchor, constant: -25),
            privacyLabel.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor, constant: -50)
        ])
    }}
