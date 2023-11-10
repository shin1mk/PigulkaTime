//
//  DrugView.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 09.11.2023.
//

import UIKit
import SnapKit

final class DrugView: UIView, UITextFieldDelegate {
    private let drugLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Drug name"
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 18)
        return titleLabel
    }()
    let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.font = UIFont.SFUITextRegular(ofSize: 18)
        textField.returnKeyType = .done
        return textField
    }()
    //MARK: Init
    init() {
        super.init(frame: .zero)
        setupConstraints()
        setupDelegates()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func setupConstraints() {
        // drug label
        addSubview(drugLabel)
        drugLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        // drug text
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(drugLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    private func setupDelegates() {
        textField.delegate = self
    }
    // Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Закрыть клавиатуру
        return true
    }
}
