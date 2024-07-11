//
//  SettingTableViewCell.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 12.07.2024.
//

import UIKit



class SettingsTableViewCell: UITableViewCell {
    
    
    
    var setting: AppService.appSetting? {
        didSet {
            updateUI()
        }
    }
    
    
    
    // MARK: - Subviews
    private lazy var settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var settingControl: UISegmentedControl = {
        let settingControl = UISegmentedControl()
        settingControl.translatesAutoresizingMaskIntoConstraints = false
        return  settingControl
    }()
    
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
        setupConstraints()
    }
    
    
    
    // MARK: - Private
    private func addSubviews() {
        //addSubview(settingLabel)
        backgroundColor = .accentColor
        addSubview(settingControl)
    }
    
    private func setupConstraints() {


        
        /*
         NSLayoutConstraint.activate([
            settingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            settingLabel.heightAnchor.constraint(equalToConstant: 25),
            settingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            settingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            settingLabel.widthAnchor.constraint(equalToConstant: 100)
         ])
         */
        NSLayoutConstraint.activate([
            settingControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            settingControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            settingControl.heightAnchor.constraint(equalToConstant: 25),
            settingControl.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -200),
            settingControl.widthAnchor.constraint(equalToConstant: 100)
        ])        
    }
    
    private func updateUI() {
        settingLabel.text = setting?.label
        
        settingControl.removeAllSegments()
        if let values = setting?.values {
            for (index, value) in values.enumerated() {
                settingControl.insertSegment(withTitle: value, at: index, animated: false)
            }
        }
    }
}
