//
//  DrugNameCustomTableCell.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 11.11.2023.
//

import UIKit
import SnapKit

final class DrugNameCustomTableCell: UITableViewCell, UITextFieldDelegate {
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Drug name"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 20)
        return titleLabel
    }()
    public let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .systemGray
        textField.textAlignment = .right
        textField.isUserInteractionEnabled = true
        textField.backgroundColor = .clear
        textField.returnKeyType = .done
        let placeholderFont = UIFont.SFUITextRegular(ofSize: 17)
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: placeholderFont as Any,
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Enter name", attributes: placeholderAttributes)
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
} //end
//MARK: Keyboard
extension DrugNameCustomTableCell {
    // Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Закрыть клавиатуру по нажатию на done
        return true
    }
    // Keyboard
    @objc func textFieldDidChange(_ textField: UITextField) {
        // Обработка изменений в текстовом поле
        if let text = textField.text {
            print("Text changed: \(text)")
        }
    }
}
