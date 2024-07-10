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
    @objc func informationButtonTapped(_ button: UIButton) {
        let aboutViewController = AboutViewController()
        self.navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemCyan
        //self.navigationController?.navigationBar.isHidden = false
    }
    
    private func addSubviews() {
        
    }
    
    private func setupConstraints() {
        
    }
    
    private func setupNavigationBar() {
        
        let informationImage = UIImage(systemName: "info.circle.fill")
        let informationButton = UIBarButtonItem(image: informationImage, style: .plain, target: self, action: #selector(informationButtonTapped))
        

        
        navigationItem.leftBarButtonItem = informationButton
    }
}

