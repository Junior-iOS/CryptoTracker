//
//  SettingsTableViewCell.swift
//  Easy Numbers
//
//  Created by NJ Development on 14/07/23.
//

import UIKit

enum SwitchButton {
    case show
    case hide
    case none
}

class SettingsTableViewCell: UITableViewCell {
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Teste"
        label.textColor = .white
        return label
    }()
    
    public lazy var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.translatesAutoresizingMaskIntoConstraints = false
        switchButton.isOn = false
        switchButton.isUserInteractionEnabled = true
        switchButton.isEnabled = true
        switchButton.addTarget(self, action: #selector(didPressSwitch), for: .valueChanged)
        return switchButton
    }()
    
    var isShowingSwitchButton: SwitchButton = .show
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        addComponents()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
    
    private func setup() {
        backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.12, alpha: 1.00)
    }
    
    private func addComponents() {
        addSubviews(nameLabel, switchButton)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: switchButton.leadingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            switchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            switchButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor)
        ])
    }
    
    @objc private func didPressSwitch(_ uiSwitch: UISwitch) {
        switch uiSwitch.tag {
        case 0:
            if uiSwitch.isOn {
                UserDefaults.standard.setValue(true, forKey: "safetySwitch")
            } else {
                UserDefaults.standard.setValue(false, forKey: "safetySwitch")
            }
        case 1:
            if uiSwitch.isOn {
                UserDefaults.standard.setValue(true, forKey: "accessibilitySwitch")
            } else {
                UserDefaults.standard.setValue(false, forKey: "accessibilitySwitch")
            }
        default: break
        }
        
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
    
    func configure(text: String, isShowingSwitchButton: SwitchButton, switchTag: Int) {
        DispatchQueue.main.async {
            let isSwitchOn = switchTag == 0
            ? UserDefaults.standard.bool(forKey: "safetySwitch")
            : UserDefaults.standard.bool(forKey: "accessibilitySwitch")
            
            self.nameLabel.text = text
            self.switchButton.isOn = isSwitchOn
        }
        
        if isShowingSwitchButton == .show {
            self.switchButton.isHidden = false
            accessoryType = .none
            accessoryView = switchButton
        } else if isShowingSwitchButton == .hide {
            removeSwitchBUtton(accessoryType: .disclosureIndicator)
        } else {
            removeSwitchBUtton(accessoryType: .none)
        }
    }
    
    private func removeSwitchBUtton(accessoryType: UITableViewCell.AccessoryType) {
        self.switchButton.isHidden = true
        self.accessoryType = accessoryType
        accessoryView = nil
    }
}
