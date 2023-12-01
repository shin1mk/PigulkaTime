//
//  FirstCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

//import UIKit
//import SnapKit
//
//// передаем из пикер вью сюда
//protocol FirstCustomTableCellDelegate: AnyObject {
//    func didSelectFirstTime(cell: FirstCustomTableCell)
//    func didToggleSwitch(cell: FirstCustomTableCell, isOn: Bool)
//}

//final class FirstCustomTableCell: UITableViewCell {
//    weak var delegate: FirstCustomTableCellDelegate?
//    //MARK: Properties
//    private let firstNotificationLabel: UILabel = {
//        let firstNotificationLabel = UILabel()
//        firstNotificationLabel.text = "--:--"
//        firstNotificationLabel.textColor = .white
//        firstNotificationLabel.textAlignment = .right
//        firstNotificationLabel.font = UIFont.SFUITextMedium(ofSize: 25)
//        return firstNotificationLabel
//    }()
//    private let bottomBorderView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemGray6 // Цвет бордера
//        return view
//    }()
//    public let switchControl: UISwitch = {
//        let switchControl = UISwitch()
//        switchControl.isOn = true
//        return switchControl
//    }()
//    //MARK: Lifecycle
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupConstraints()
//        setupGesture()
//        setupTarget()
//    }
//    required init?(coder aDecoder: NSCoder) {
//        return nil
//    }
//    //MARK: Methods
//    private func setupConstraints() {
//        backgroundColor = .clear
//        // firstTitleLabel
//        addSubview(firstNotificationLabel)
//        firstNotificationLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview()
//        }
//        // switchControl
//        contentView.addSubview(switchControl)
//        switchControl.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.trailing.equalToSuperview().offset(-10)
//        }
//        // bottomBorderView
//        addSubview(bottomBorderView)
//        bottomBorderView.snp.makeConstraints { make in
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.height.equalTo(1) // Высота
//        }
//    }
//    // тап по ячейке
//    private func setupGesture() {
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
//        contentView.addGestureRecognizer(tapGesture)
//    }
//    // target
//    private func setupTarget() {
//        switchControl.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
//
//        // Восстанавливаем сохраненное состояние свитча
//        if let savedFirstSwitchState = UserDefaults.standard.value(forKey: "FirstSwitchState") as? Bool {
//            switchControl.isOn = savedFirstSwitchState
//            updateUIForSwitchState(isOn: savedFirstSwitchState)
//        } else {
//            // Если в UserDefaults нет сохраненного значения, устанавливаем свитч и метку по умолчанию
//            switchControl.isOn = false
//            updateUIForSwitchState(isOn: false)
//        }
//    }
//
//    // состояние кнопки
//    @objc private func switchValueChanged() {
//        // Вызывайте делегат или выполните другие действия в зависимости от значения бегунка
//        delegate?.didToggleSwitch(cell: self, isOn: switchControl.isOn)
//        // Обновляем UI в зависимости от состояния свитча
//        updateUIForSwitchState(isOn: switchControl.isOn)
//        // Сохраняем состояние в UserDefaults
//        saveSwitchState(isOn: switchControl.isOn)
//    }
//
//    // Обновление UI в зависимости от состояния свитча
//    private func updateUIForSwitchState(isOn: Bool) {
//        if isOn {
//            firstNotificationLabel.textColor = .white
//        } else {
//            firstNotificationLabel.textColor = .systemGray
//        }
//    }
//    // стейт свитч кнопки
//    func saveSwitchState(isOn: Bool) {
//        let defaults = UserDefaults.standard
//        defaults.set(isOn, forKey: "FirstSwitchState")
//    }
//    // ячейка нажата вызываем протокол
//    @objc private func cellTapped() {
//        delegate?.didSelectFirstTime(cell: self)
//    }
//    // установить время в ячейку
//    func setFirstTimeText(_ text: String) {
//        firstNotificationLabel.text = text
//    }
//
//
//} //end
//
//
//  FirstCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit
import SnapKit

protocol FirstCustomTableCellDelegate: AnyObject {
    func didSelectFirstTime(cell: FirstCustomTableCell)
    func didToggleSwitch(cell: FirstCustomTableCell, isOn: Bool)
}

final class FirstCustomTableCell: UITableViewCell {
    weak var delegate: FirstCustomTableCellDelegate?

    private let firstNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "--:--"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont.SFUITextMedium(ofSize: 25)
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

    private let switchStateKey = "FirstSwitchState"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupGesture()
        setupTarget()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    private func setupConstraints() {
        backgroundColor = .clear

        addSubview(firstNotificationLabel)
        firstNotificationLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }

        contentView.addSubview(switchControl)
        switchControl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
        }

        addSubview(bottomBorderView)
        bottomBorderView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
    }

    private func setupTarget() {
        switchControl.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)

        if let savedFirstSwitchState = UserDefaults.standard.value(forKey: switchStateKey) as? Bool {
            switchControl.isOn = savedFirstSwitchState
            updateUIForSwitchState(isOn: savedFirstSwitchState)
        } else {
            switchControl.isOn = false
            updateUIForSwitchState(isOn: false)
        }
    }

    @objc private func switchValueChanged() {
        delegate?.didToggleSwitch(cell: self, isOn: switchControl.isOn)
        updateUIForSwitchState(isOn: switchControl.isOn)
        saveSwitchState(isOn: switchControl.isOn)
    }

    private func updateUIForSwitchState(isOn: Bool) {
        firstNotificationLabel.textColor = isOn ? .white : .systemGray
    }

    func saveSwitchState(isOn: Bool) {
        UserDefaults.standard.set(isOn, forKey: switchStateKey)
    }

    @objc private func cellTapped() {
        delegate?.didSelectFirstTime(cell: self)
    }

    func setFirstTimeText(_ text: String) {
        firstNotificationLabel.text = text
    }
}
