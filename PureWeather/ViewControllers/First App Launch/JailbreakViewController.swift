//
//  JailbreakViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 18.07.2024.
//



import Foundation
import UIKit



class JailbreakViewController: UIViewController {
    
    
    
    // MARK: - Subviews
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "nosign")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        let text = String(localized: "This application is not available for devices with Jailbreak. We strongly condemn hacking iOS and installation of illegal software!")
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(textLabel)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: safeAreaGuide.centerYAnchor, constant: -150),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textLabel.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor, constant: -20),
            textLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -20)
        ])
    }
}

