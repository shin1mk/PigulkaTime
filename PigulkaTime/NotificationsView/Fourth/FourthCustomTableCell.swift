//
//  FourthCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 02.12.2023.
//

import UIKit
import SnapKit

protocol FourthCustomTableCellDelegate: AnyObject {
    func didSelectFourthTime(cell: FourthCustomTableCell)
    func didFourthToggleSwitch(cell: FourthCustomTableCell, isOn: Bool)
}

final class FourthCustomTableCell: UITableViewCell {
    weak var delegate: FourthCustomTableCellDelegate?
    //MARK: Properties
    private let fourthNotificationLabel: UILabel = {
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
    private let switchStateKey = "FourthSwitchState"
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
        addSubview(fourthNotificationLabel)
        fourthNotificationLabel.snp.makeConstraints { make in
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
        if let savedFourthSwitchState = UserDefaults.standard.value(forKey: switchStateKey) as? Bool {
            switchControl.isOn = savedFourthSwitchState
            updateUIForSwitchState(isOn: savedFourthSwitchState)
        } else {
            switchControl.isOn = false
            updateUIForSwitchState(isOn: false)
        }
    }
    // switch
    @objc private func switchValueChanged() {
        delegate?.didFourthToggleSwitch(cell: self, isOn: switchControl.isOn)
        updateUIForSwitchState(isOn: switchControl.isOn)
        saveSwitchState(isOn: switchControl.isOn)
    }
    // цвет часов
    func updateUIForSwitchState(isOn: Bool) {
        fourthNotificationLabel.textColor = isOn ? .white : .systemGray
    }
    // сохраняем положение свитча
    func saveSwitchState(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: switchStateKey)
    }

    @objc private func cellTapped() {
        delegate?.didSelectFourthTime(cell: self)
    }

    func setFourthTimeText(_ text: String) {
        fourthNotificationLabel.text = text
    }
}
