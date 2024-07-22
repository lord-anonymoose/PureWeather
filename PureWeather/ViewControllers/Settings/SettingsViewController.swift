//
//  MainViewController.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 09.07.2024.
//

import UIKit

class SettingsViewController: UIViewController {
    


    // MARK: - Private
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var clearCitiesButton: UIButton = {
        let button = UIButton()
        let ittle = String(localized: "Clear city data")
        button.addTarget(self, action: #selector(clearCitiesButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondarySystemFill
        return button
    }()
    
    private lazy var aboutDeveloperButton: UIButton = {
        let button = UIButton()
        let title = String(localized: "About Developer")
        let attributedTitle = NSAttributedString(
            string: title,
            attributes: [
                .foregroundColor: UIColor.secondaryLabel,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
        )        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(aboutDeveloperButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    // MARK: -  Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNavigationBar()
        addSubviews()
        setupConstraints()
        setupDelegates()
    }
    
    
    
    // MARK: - Actions
    @objc func aboutDeveloperButtonTapped(_ button: UIButton) {
        let aboutViewController = AboutViewController()
        self.navigationController?.pushViewController(aboutViewController, animated: true)
    }
    
    @objc func clearCitiesButtonTapped(_ button: UIButton) {
        print("clearCitiesButtonTapped")
    }
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        print("isFahrenheit: \(AppService.shared().isFahrenheit())")
        print("is12hFormat: \(AppService.shared().is12hFormat())")
        print("isAmericanSystem: \(AppService.shared().isAmericanSystem())")
        print("isFirstLaunch: \(AppService.shared().isFirstLaunch())")
    }
    
    private func setupNavigationBar() {
        let title = String(localized: "Settings")
        self.navigationItem.title = title
    }
    
    private func addSubviews() {
        view.addSubview(settingsTableView)
        view.addSubview(clearCitiesButton)
        view.addSubview(aboutDeveloperButton)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            settingsTableView.heightAnchor.constraint(equalToConstant: 300),
            settingsTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            clearCitiesButton.topAnchor.constraint(equalTo: settingsTableView.bottomAnchor, constant: 25),
            clearCitiesButton.heightAnchor.constraint(equalToConstant: 50),
            clearCitiesButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 25),
            clearCitiesButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -25),
        ])
        
        NSLayoutConstraint.activate([
            aboutDeveloperButton.topAnchor.constraint(equalTo: settingsTableView.bottomAnchor, constant: 25),
            aboutDeveloperButton.heightAnchor.constraint(equalToConstant: 25),
            aboutDeveloperButton.centerXAnchor.constraint(equalTo: safeAreaGuide.centerXAnchor),
        ])
    }
}



extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        // Configure the cell with appropriate setting based on indexPath.row
        switch indexPath.row {
        case 0:
            cell.setting = .temperature // Assuming AppService.appSetting.notifications exists
        case 1:
            cell.setting = .windSpeed // Assuming AppService.appSetting.sounds exists
        case 2:
            cell.setting = .timeFormat // Assuming AppService.appSetting.privacy exists
        case 3:
            cell.setting = .notifications // Assuming AppService.appSetting.general exists
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    private func setupDelegates() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
        settingsTableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsTableViewCell")
    }
}
