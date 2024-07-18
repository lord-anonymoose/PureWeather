//
//  Buttons.swift
//  PureWeather
//
//  Created by Philipp Lazarev on 10.07.2024.
//

import UIKit



class CustomButton: UIButton {
    private var backgroundColors: [UInt: UIColor] = [:]

    override func layoutSubviews() {
        super.layoutSubviews()
        updateBackgroundColor()
    }

    func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
        backgroundColors[controlState.rawValue] = color
        if state == controlState {
            updateBackgroundColor()
        }
    }

    private func updateBackgroundColor() {
        let currentColor = backgroundColors[state.rawValue] ?? backgroundColors[UIControl.State.normal.rawValue]
        layer.backgroundColor = currentColor?.cgColor
        layer.masksToBounds = true
        layer.cornerRadius = 10 // Set your desired corner radius here
    }

    override var isHighlighted: Bool {
        didSet {
            updateBackgroundColor()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    override var isSelected: Bool {
        didSet {
            updateBackgroundColor()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    override var isEnabled: Bool {
        didSet {
            updateBackgroundColor()
            setNeedsLayout()
            layoutIfNeeded()
        }
    }
}
