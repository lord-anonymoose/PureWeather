//
//  MainViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import UIKit

class MainViewController: UIViewController {
    


    // MARK: - Private
    
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addSubviews()
        setupConstraints()
        setupNavigationBar()
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
    
    private func addSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupNavigationBar() {
        let settingsImage = UIImage(systemName: "gear")
        let settingsButton = UIBarButtonItem(image: settingsImage, style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = settingsButton
    }
}

