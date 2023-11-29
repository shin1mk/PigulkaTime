//
//  FirstCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit
import SnapKit

// передаем из пикер вью сюда
protocol FirstCustomTableCellDelegate: AnyObject {
    func didSelectFirstTime(cell: FirstCustomTableCell)
    func didToggleSwitch(cell: FirstCustomTableCell, isOn: Bool)
}

final class FirstCustomTableCell: UITableViewCell {
    weak var delegate: FirstCustomTableCellDelegate?
    //MARK: Properties
    private let firstTitleLabel: UILabel = {
        let firstTitleLabel = UILabel()
        firstTitleLabel.text = "First notification"
        firstTitleLabel.textColor = .white
        firstTitleLabel.textAlignment = .left
        firstTitleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return firstTitleLabel
    }()
    private let firstNotificationLabel: UILabel = {
        let firstNotificationLabel = UILabel()
        firstNotificationLabel.text = "Choose \u{2192}"
        firstNotificationLabel.textColor = .systemGray
        firstNotificationLabel.textAlignment = .right
        firstNotificationLabel.font = UIFont.SFUITextRegular(ofSize: 15)
        return firstNotificationLabel
    }()
    private let firstDaysLabel: UILabel = {
        let firstDaysLabel = UILabel()
        firstDaysLabel.text = "Days left"
        firstDaysLabel.textColor = .systemGray
        firstDaysLabel.textAlignment = .right
        firstDaysLabel.font = UIFont.SFUITextRegular(ofSize: 15)
        return firstDaysLabel
    }()
    private let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6 // Цвет бордера
        return view
    }()
    private let switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.isOn = true
        return switchControl
    }()
    
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
        // firstTitleLabel
        addSubview(firstTitleLabel)
        firstTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
        }
        // firstDaysLabel
        addSubview(firstDaysLabel)
        firstDaysLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
        }
        // firstNotificationLabel
        addSubview(firstNotificationLabel)
        firstNotificationLabel.snp.makeConstraints { make in
            make.top.equalTo(firstTitleLabel.snp.top)
            make.trailing.equalToSuperview().offset(-10)
        }
        // switchControl
        contentView.addSubview(switchControl)
        switchControl.snp.makeConstraints { make in
            make.top.equalTo(firstNotificationLabel.snp.bottom).offset(5)
            make.trailing.equalToSuperview().offset(-10)
        }
        // bottomBorderView
        addSubview(bottomBorderView)
        bottomBorderView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1) // Высота
        }
    }
    // тап по ячейке
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
        contentView.addGestureRecognizer(tapGesture)
    }
    // target
    private func setupTarget() {
        switchControl.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    @objc private func switchValueChanged() {
        // Вызывайте делегат или выполните другие действия в зависимости от значения бегунка
        cancelAllNotifications()
        delegate?.didToggleSwitch(cell: self, isOn: switchControl.isOn)
        // Изменяем цвет текста в зависимости от состояния свитча
        if switchControl.isOn {
            firstTitleLabel.textColor = .white
            firstDaysLabel.textColor = .systemGray
            firstNotificationLabel.textColor = .systemGray
        } else {
            firstTitleLabel.textColor = .systemGray5
            firstDaysLabel.textColor = .systemGray5
            firstNotificationLabel.textColor = .systemGray5
        }
    }
    // ячейка нажата вызываем протокол
    @objc private func cellTapped() {
        delegate?.didSelectFirstTime(cell: self)
    }
    // установить время в ячейку
    func setFirstTimeText(_ text: String) {
        firstNotificationLabel.text = text
    }
    // установить дней в ячейку
    func setFirstDaysText(_ text: String) {
        firstDaysLabel.text = text
    }
    // Ваш метод отмены уведомлений
    func cancelAllNotifications() {
        DispatchQueue.main.async {
            let notificationCenter = UNUserNotificationCenter.current()
            // Получаем список всех текущих уведомлений
            notificationCenter.getPendingNotificationRequests { requests in
                // Удаляем каждое уведомление по его идентификатору
                for request in requests {
                    notificationCenter.removePendingNotificationRequests(withIdentifiers: [request.identifier])
                    print("Notification removed with identifier: \(request.identifier)")
                }
            }
        }
    }
} //end
