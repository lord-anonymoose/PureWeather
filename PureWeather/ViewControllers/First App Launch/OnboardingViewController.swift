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
        let image = UIImage(named: "AppIconImage")
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = String(localized: "Hello!", comment: "Onboarding welcome!")
        label.font = .titleFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var onboardingTextView: UITextView = {
        let textView = UITextView()
        textView.text = String(localized: "Thank you for choosing PureWeather - minimalistic weather app. \n\nWe appreciate your time and only provide you data that you truly need. And if you need more detailed weather forecast - it's just a swipe away!")
        textView.font = .labelFont
        //textView.numberOfLines = 0
        textView.textAlignment = .natural
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        let title = String(localized: "Let's go!", comment: "Let's go button for OnboardingViewController")
        button.setTitle(title, for: .normal)
        button.backgroundColor = .accentColor
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
        view.addSubview(iconImageView)
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        view.addSubview(onboardingTextView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
    
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor, constant: -250),
            iconImageView.heightAnchor.constraint(equalToConstant: 150),
            iconImageView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 50),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -25),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            nextButton.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            nextButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25)
        ])
    
        NSLayoutConstraint.activate([
            onboardingTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            onboardingTextView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -25),
            onboardingTextView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 15),
            onboardingTextView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -15)
        ])
    }
}

