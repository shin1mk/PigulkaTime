//
//  CustomTableViewCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 08.11.2023.
//

import UIKit
import SnapKit

protocol CustomTableViewCellDelegate: AnyObject {
    func setLabelText(_ text: String)
//    func setTypeLabelText(_ text: String)
    func setDosageLabelText(_ text: String)
}

final class CustomTableViewCell: UITableViewCell {
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = ""
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextBold(ofSize: 25)
        return titleLabel
    }()
    private let typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.text = "pill"
        typeLabel.textColor = .gray
        typeLabel.font = UIFont.SFUITextRegular(ofSize: 15)
        return typeLabel
    }()
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "Today"
        dateLabel.textColor = .gray
        dateLabel.font = UIFont.SFUITextRegular(ofSize: 15)
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
        // dosage Label
        addSubview(dosageLabel)
        dosageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.leading.equalTo(titleLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
        // typeLabel
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(-10)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        // date Label
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
    // общий метод для установки текста в titleLabel
    func setTitleLabelText(_ text: String) {
        titleLabel.text = text
    }
    func setTypeLabelText(_ text: String) {
        typeLabel.text = text
    }
    func setDosageLabelText(_ text: String) {
        dosageLabel.text = text
    }
} //end
