//
//  CustomTableViewCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 08.11.2023.
//

import UIKit
import SnapKit

final class MainViewCustomTableCell: UITableViewCell {
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "title"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextMedium(ofSize: 25)
        return titleLabel
    }()
    private let dosageLabel: UILabel = {
        let dosageLabel = UILabel()
        dosageLabel.text = "dosage"
        dosageLabel.textColor = .systemGray
        dosageLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return dosageLabel
    }()
    private let typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.text = "type"
        typeLabel.textColor = .systemGray
        typeLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return typeLabel
    }()
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "date"
        dateLabel.textColor = .systemGray
        dateLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return dateLabel
    }()
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupTarget()
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
            make.leading.equalToSuperview()
        }
        // typeLabel
        addSubview(dosageLabel)
        dosageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(-10)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        // date Label
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.leading.equalTo(dosageLabel.snp.trailing).offset(10)
            make.top.equalTo(dosageLabel.snp.top)
            make.bottom.equalToSuperview().offset(-10)
        }
        // dosage Label
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeLabel.snp.trailing).offset(10)
            make.top.equalTo(typeLabel.snp.top)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    // target
    private func setupTarget() {
        
    }
    // общий метод для установки текста в Labels
    func setTitleLabelText(_ text: String) {
        titleLabel.text = text
    }
    func setDosageLabelText(_ text: String) {
        dosageLabel.text = text
    }
    func setTypeLabelText(_ text: String) {
        typeLabel.text = text
    }
    func setDateLabelText(_ text: String) {
        dateLabel.text = text
    }
} //end
