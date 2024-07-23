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
        settingControl.isUserInteractionEnabled = true
        settingControl.translatesAutoresizingMaskIntoConstraints = false
        return  settingControl
    }()
    
    
    
    // MARK: - Actions
    @objc private func segmentControlValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        if let title = sender.titleForSegment(at: selectedIndex) {
            print("\(title) selected")
        }
    }
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
        addSubview(settingLabel)
        addSubview(settingControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            settingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            settingLabel.heightAnchor.constraint(equalToConstant: 25),
            settingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            settingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
         ])

        NSLayoutConstraint.activate([
            settingControl.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            settingControl.heightAnchor.constraint(equalToConstant: 25),
            settingControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            settingControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            settingControl.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func updateUI() {
        settingLabel.text = setting?.label
        
        settingControl.removeAllSegments()
        if let values = setting?.values {
            for (index, value) in values.enumerated() {
                let action1 = UIAction(title: value, handler: { _ in print("Option 1 selected") })
                settingControl.insertSegment(action: action1, at: index, animated: true)
            }
        }
        settingControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
        settingControl.setEnabled(true, forSegmentAt: 1)
        settingControl.isUserInteractionEnabled = true
    }
}
