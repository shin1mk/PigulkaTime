//
//  DosageCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 11.11.2023.
//

import UIKit
import SnapKit

final class DosageCustomTableCell: UITableViewCell, UITextFieldDelegate {
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "PillVC_title"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return titleLabel
    }()
    private let dosageLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.text = "PillVC_dosage"
        typeLabel.textColor = .white
        typeLabel.textAlignment = .right
        typeLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return typeLabel
    }()
    //MARK: Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupTarget()
        setupDelegate()
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
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview()
        }
        // textField
        addSubview(dosageLabel)
        dosageLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    // target
    private func setupTarget() {
//        typeLabel.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    // delegate
    private func setupDelegate() {
//        typeLabel.delegate = self
    }
} //end
//MARK:
