//
//  ThirdCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 02.12.2023.
//

import UIKit
import SnapKit

protocol ThirdCustomTableCellDelegate: AnyObject {
    func didSelectThirdTime(cell: ThirdCustomTableCell)
    func didThirdToggleSwitch(cell: ThirdCustomTableCell, isOn: Bool)
}

final class ThirdCustomTableCell: UITableViewCell {
    weak var delegate: ThirdCustomTableCellDelegate?
    //MARK: Properties
    private let thirdNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "--:--"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.SFUITextMedium(ofSize: 35)
        return label
    }()
    private let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        return view
    }()
    public let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        return switchControl
    }()
    private let switchStateKey = "ThirdSwitchState"
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupGesture()
        setupTarget()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupConstraints() {
        backgroundColor = .clear
        // label
        addSubview(thirdNotificationLabel)
        thirdNotificationLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        // switcher
        contentView.addSubview(switchControl)
        switchControl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }
        // line
        addSubview(bottomBorderView)
        bottomBorderView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    // gestures
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
    }
    // target
    private func setupTarget() {
        switchControl.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        // switch state
        if let savedThirdSwitchState = UserDefaults.standard.value(forKey: switchStateKey) as? Bool {
            switchControl.isOn = savedThirdSwitchState
            updateUIForSwitchState(isOn: savedThirdSwitchState)
        } else {
            switchControl.isOn = false
            updateUIForSwitchState(isOn: false)
        }
    }
    // switch
    @objc private func switchValueChanged() {
        delegate?.didThirdToggleSwitch(cell: self, isOn: switchControl.isOn)
        updateUIForSwitchState(isOn: switchControl.isOn)
        saveSwitchState(isOn: switchControl.isOn)
    }

    func updateUIForSwitchState(isOn: Bool) {
        thirdNotificationLabel.textColor = isOn ? .white : .systemGray
    }

    func saveSwitchState(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: switchStateKey)
    }

    @objc private func cellTapped() {
        delegate?.didSelectThirdTime(cell: self)
    }

    func setThirdTimeText(_ text: String) {
        thirdNotificationLabel.text = text
    }
}
