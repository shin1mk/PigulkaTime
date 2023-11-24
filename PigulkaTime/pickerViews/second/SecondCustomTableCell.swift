//
//  SecondCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit
import SnapKit

// передаем из пикер вью сюда
protocol SecondCustomTableCellDelegate: AnyObject {
    func didSelectSecondTime(cell: SecondCustomTableCell)
}

final class SecondCustomTableCell: UITableViewCell {
    weak var delegate: SecondCustomTableCellDelegate?
    //MARK: Properties
    private let secondTitleLabel: UILabel = {
        let secondTitleLabel = UILabel()
        secondTitleLabel.text = "Second notification"
        secondTitleLabel.textColor = .white
        secondTitleLabel.textAlignment = .left
        secondTitleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return secondTitleLabel
    }()
    private let secondNotificationLabel: UILabel = {
        let secondNotificationLabel = UILabel()
        secondNotificationLabel.text = "Choose \u{2192}"
        secondNotificationLabel.textColor = .systemGray
        secondNotificationLabel.textAlignment = .right
        secondNotificationLabel.font = UIFont.SFUITextRegular(ofSize: 15)
        return secondNotificationLabel
    }()
    private let secondDaysLabel: UILabel = {
        let secondDaysLabel = UILabel()
        secondDaysLabel.text = "Days left"
        secondDaysLabel.textColor = .systemGray
        secondDaysLabel.textAlignment = .right
        secondDaysLabel.font = UIFont.SFUITextRegular(ofSize: 15)
        return secondDaysLabel
    }()
    private let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6 // Цвет бордера
        return view
    }()
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupGesture()
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupConstraints() {
        backgroundColor = .clear
        // secondTitleLabel
        addSubview(secondTitleLabel)
        secondTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
        }
        // firstDaysLabel
        addSubview(secondDaysLabel)
        secondDaysLabel.snp.makeConstraints { make in
            make.top.equalTo(secondTitleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview()
        }
        // secondNotificationLabel
        addSubview(secondNotificationLabel)
        secondNotificationLabel.snp.makeConstraints { make in
            make.top.equalTo(secondTitleLabel.snp.top)
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
    // ячейка нажата вызываем протокол
    @objc private func cellTapped() {
        delegate?.didSelectSecondTime(cell: self)
    }
    // установить текст в ячейку
    func setSecondTimeText(_ text: String) {
        secondNotificationLabel.text = text
    }
} //end

