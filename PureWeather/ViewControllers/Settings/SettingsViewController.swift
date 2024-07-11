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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
    
    
    
    // MARK: - Private
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupNavigationBar() {
        let title = String(localized: "Settings")
        self.navigationItem.title = title
    }
    
    private func addSubviews() {
        view.addSubview(settingsTableView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            settingsTableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            settingsTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            settingsTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            settingsTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
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
