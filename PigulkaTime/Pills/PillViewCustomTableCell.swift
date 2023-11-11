//
//  PillViewCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 11.11.2023.
//

import UIKit
import SnapKit

final class PillViewCustomTableCell: UITableViewCell, UITextFieldDelegate {
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "PillVC_title"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return titleLabel
    }()
    private let typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.text = "PillVC_type"
        typeLabel.textColor = .white
        typeLabel.textAlignment = .right
        typeLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return typeLabel
    }()
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter text here"
        textField.textColor = .white
        textField.isUserInteractionEnabled = true
        textField.backgroundColor = .clear
        textField.returnKeyType = .done
        return textField
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
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.top)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    // target
    private func setupTarget() {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    // delegate
    private func setupDelegate() {
        textField.delegate = self
    }
    // Keyboard
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // Обработка изменений в текстовом поле
        if let text = textField.text {
            // Обновите данные в вашем массиве или другие действия по мере ввода
            print("Text changed: \(text)")
        }
    }
    // Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Закрыть клавиатуру
        return true
    }
} //end
