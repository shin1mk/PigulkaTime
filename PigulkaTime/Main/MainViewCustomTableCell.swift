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
        titleLabel.text = ""
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextMedium(ofSize: 25)
        return titleLabel
    }()
    private let dosageLabel: UILabel = {
        let dosageLabel = UILabel()
        dosageLabel.text = ""
        dosageLabel.textColor = .systemGray
        dosageLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return dosageLabel
    }()
    private let typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.text = ""
        typeLabel.textColor = .systemGray
        typeLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return typeLabel
    }()
    private let frequencyLabel: UILabel = {
        let frequencyLabel = UILabel()
        frequencyLabel.text = ""
        frequencyLabel.textColor = .systemGray
        frequencyLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return frequencyLabel
    }()
    private let daysLabel: UILabel = {
        let daysLabel = UILabel()
        daysLabel.text = ""
        daysLabel.textColor = .systemGray
        daysLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return daysLabel
    }()
    private let timesLabel: UILabel = {
        let timesLabel = UILabel()
        timesLabel.text = ""
        timesLabel.textColor = .systemGray
        timesLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return timesLabel
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
        layer.borderWidth = 0.5
        layer.cornerRadius = 5
        layer.backgroundColor = UIColor.systemGray6.cgColor
        layer.borderColor = UIColor.systemGray5.cgColor
        // title Label
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(10)
        }
        // dosageLabel
        addSubview(dosageLabel)
        dosageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(20)
            
            //            make.bottom.equalToSuperview().offset(-10)
        }
        // typeLabel
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(dosageLabel.snp.top)
            make.leading.equalTo(dosageLabel.snp.trailing).offset(5)
            make.height.equalTo(20)
            
            //            make.bottom.equalToSuperview().offset(-10)
        }
        // frequencyLabel
        addSubview(frequencyLabel)
        frequencyLabel.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(20)
            
            //            make.bottom.equalToSuperview().offset(-10)
        }
        
        // times Label
        addSubview(timesLabel)
        timesLabel.snp.makeConstraints { make in
            make.top.equalTo(frequencyLabel.snp.top)
            make.leading.equalTo(frequencyLabel.snp.trailing).offset(10)
            make.height.equalTo(20)
            
            //            make.bottom.equalToSuperview().offset(-10)
        }
        // days Label
        addSubview(daysLabel)
        daysLabel.snp.makeConstraints { make in
            make.top.equalTo(frequencyLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(20)
            
            //            make.bottom.equalToSuperview().offset(-10)
        }
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
    func setFrequencyLabelText(_ text: String) {
        frequencyLabel.text = text
    }
    func setDaysLabelText(_ text: String) {
        daysLabel.text = text
    }
    func setTimesLabelText(_ text: String) {
        timesLabel.text = text
    }
    
} //end
