//
//  ViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import UIKit

class OnboardingViewController: UIViewController {

    

    // MARK: - Private
    private lazy var iconImageView: UIImageView = {
        let image = UIImage(named: "")
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome!"
        label.backgroundColor = .green
        label.font = .titleFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Thank you for choosing PureWeather - minimalistic weather app. \n\nWe appreciate your time and only provide you data that you truly need. And if you need more detailed weather forecast - it's just a swipe away!"
        label.font = .labelFont
        label.backgroundColor = .red
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Let's go!", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10.0
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
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
    @objc func nextButtonTapped(_ button: UIButton) {
        print("Button tapped")
    }
    
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        //view.addSubview(iconImageView)
        //view.addSubview(titleLabel)
        view.addSubview(nextButton)
        //view.addSubview(textLabel)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
    
        /*
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor, constant: -100),
            iconImageView.heightAnchor.constraint(equalToConstant: 100),
            iconImageView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 25),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor)
        ])
        */
        
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            nextButton.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            nextButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25)
            //nextButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -25),
            //nextButton.heightAnchor.constraint(equalToConstant: 50),
            //nextButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            //nextButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25)
        ])
        
        /*
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            textLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -25),
            textLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            textLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25)
        ])
        */
    }
}

