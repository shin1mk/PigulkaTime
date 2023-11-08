//
//  CustomTableViewCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 08.11.2023.
//

import UIKit
import SnapKit

final class CustomTableViewCell: UITableViewCell {
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Custom Name"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextBold(ofSize: 25)
        return titleLabel
    }()
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "Today"
        dateLabel.textColor = .white
        dateLabel.font = UIFont.SFUITextRegular(ofSize: 16)
        return dateLabel
    }()
    private let dosageLabel: UILabel = {
        let dosageLabel = UILabel()
        dosageLabel.text = "1pc"
        dosageLabel.textColor = .white
        dosageLabel.font = UIFont.SFUITextBold(ofSize: 25)
        return dosageLabel
    }()
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    //MARK: Methods
    private func setupConstraints() {
        backgroundColor = .clear
        // title Label
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview() // Установите отступ слева на 15 поинтов
        }
        // dosage Label
        addSubview(dosageLabel)
        dosageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.leading.equalTo(titleLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
        // date Label
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview() // Установите отступ слева на 15 поинтов
            make.bottom.equalToSuperview()
        }
    }
}
