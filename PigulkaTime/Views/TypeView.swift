//
//  TypeView.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 09.11.2023.
//

import UIKit
import SnapKit

//MARK: Type Pills
final class TypeView: UIView, UIPickerViewDataSource , UIPickerViewDelegate{
    private var isPickerOpen = false
    
    private let typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.text = "Type"
        typeLabel.textColor = .gray
        typeLabel.textAlignment = .left
        typeLabel.font = UIFont.SFUITextRegular(ofSize: 18)
        return typeLabel
    }()
    private let typeButton: UIButton = {
        let typeButton = UIButton()
        typeButton.setTitle("", for: .normal)
        typeButton.titleLabel?.font = UIFont.SFUITextRegular(ofSize: 18)
        typeButton.setTitleColor(.white, for: .normal)
        typeButton.layer.borderWidth = 0.1
        typeButton.layer.cornerRadius = 5
        typeButton.layer.borderColor = UIColor.lightGray.cgColor
        typeButton.contentHorizontalAlignment = .left
        return typeButton
    }()
    private let typePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    private let donePickerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = UIFont.SFUITextHeavy(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    //MARK: Init
    init() {
        super.init(frame: .zero)
        setupConstraints()
        setupDelegates()
        setupTarget()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    private func setupConstraints() {
        // typeLabel
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        // typeButton
        addSubview(typeButton)
        typeButton.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        // typePickerView
        addSubview(typePickerView)
        typePickerView.isHidden = true
        typePickerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-120)
            make.height.equalTo(0)
        }
        // done picker view button
        addSubview(donePickerButton)
        donePickerButton.isHidden = true
        donePickerButton.snp.makeConstraints { make in
            make.bottom.equalTo(typePickerView.snp.top).offset(100)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    private func setupTarget() {
        typeButton.addTarget(self, action: #selector(typeButtonTapped), for: .touchUpInside)
        donePickerButton.addTarget(self, action: #selector(donePickerButtonTapped), for: .touchUpInside)
    }
    private func setupDelegates() {
        typePickerView.delegate = self
        typePickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Один компонент
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5 // Пять элементов в компоненте
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Здесь возвращаем текст для каждого элемента в компоненте
        switch row {
        case 0:
            return "Pills"
        case 1:
            return "Drops"
        case 2:
            return "Ointment"
        case 3:
            return "Tablets"
        case 4:
            return "Syrup"
        default:
            return "Capsules"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Здесь устанавливаем текст кнопки в соответствии с выбранным элементом
        let selectedText = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        typeButton.setTitle(selectedText, for: .normal)
    }
    // type button action
    @objc private func typeButtonTapped() {
        isPickerOpen.toggle()
        typePickerView.isHidden = !isPickerOpen
        typePickerView.snp.updateConstraints { make in
            make.height.equalTo(isPickerOpen ? 250 : 0)
        }
        donePickerButton.isHidden = !isPickerOpen
    }
    
    @objc private func donePickerButtonTapped() {
        isPickerOpen = false
        typePickerView.isHidden = true
        typePickerView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        donePickerButton.isHidden = true
        // set выбранный элемент в кнопку "TypeButton"
        let selectedRow = typePickerView.selectedRow(inComponent: 0)
        let selectedText = self.pickerView(typePickerView, titleForRow: selectedRow, forComponent: 0)
        typeButton.setTitle(selectedText, for: .normal)
    }
}
