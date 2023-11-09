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
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "add pill"
        textField.textColor = .white
        textField.font = UIFont.SFUITextRegular(ofSize: 22)
        return textField
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
            make.leading.equalToSuperview()
        }
        // dosage Label
        addSubview(dosageLabel)
        dosageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.leading.equalTo(titleLabel.snp.trailing).offset(15)
            make.trailing.equalToSuperview()
        }
        // textField
        //        addSubview(textField)
        //        textField.snp.makeConstraints { make in
        //            make.top.equalToSuperview()
        //            make.leading.equalToSuperview()
        //            make.trailing.equalToSuperview()
        //        }
        // date Label
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(-10)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    // target
    private func setupTarget() {
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    // textField
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // Обработка изменений в текстовом поле
        if let text = textField.text {
            print("Text changed: \(text)")
        }
    }
} //end
