//
//  DosageView.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 09.11.2023.
//

import UIKit
import SnapKit

final class DosageView: UIView, UIPickerViewDataSource , UIPickerViewDelegate{
    private var isPickerOpen = false
    
    private let dosageLabel: UILabel = {
        let dosageLabel = UILabel()
        dosageLabel.text = "Dosage"
        dosageLabel.textColor = .gray
        dosageLabel.textAlignment = .left
        dosageLabel.font = UIFont.SFUITextRegular(ofSize: 18)
        return dosageLabel
    }()
    private let dosageButton: UIButton = {
        let dosageButton = UIButton()
        dosageButton.setTitle("", for: .normal)
        dosageButton.titleLabel?.font = UIFont.SFUITextRegular(ofSize: 18)
        dosageButton.setTitleColor(.white, for: .normal)
        dosageButton.layer.borderWidth = 0.1
        dosageButton.layer.cornerRadius = 5
        dosageButton.layer.borderColor = UIColor.lightGray.cgColor
        dosageButton.contentHorizontalAlignment = .left
        return dosageButton
    }()
    private let dosagePickerView: UIPickerView = {
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
        addSubview(dosageLabel)
        dosageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }
        // typeButton
        addSubview(dosageButton)
        dosageButton.snp.makeConstraints { make in
            make.top.equalTo(dosageLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        // typePickerView
        addSubview(dosagePickerView)
        dosagePickerView.isHidden = true
        dosagePickerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-120)
            make.height.equalTo(0)
        }
        // done picker view button
        addSubview(donePickerButton)
        donePickerButton.isHidden = true
        donePickerButton.snp.makeConstraints { make in
            make.bottom.equalTo(dosagePickerView.snp.top).offset(100)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    
    private func setupTarget() {
        dosageButton.addTarget(self, action: #selector(dosageButtonTapped), for: .touchUpInside)
        donePickerButton.addTarget(self, action: #selector(donePickerButtonTapped), for: .touchUpInside)
    }
    private func setupDelegates() {
        dosagePickerView.delegate = self
        dosagePickerView.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // Один компонент
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10 // Пять элементов в компоненте
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Здесь возвращаем текст для каждого элемента в компоненте
        switch row {
        case 0:
            return "0.5"
        case 1:
            return "1.5"
        case 2:
            return "2"
        case 3:
            return "3"
        case 4:
            return "4"
        case 5:
            return "5"
        case 6:
            return "6"
        case 7:
            return "7"
        case 8:
            return "8"
        case 9:
            return "9"
        default:
            return "1"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Здесь устанавливаем текст кнопки в соответствии с выбранным элементом
        let selectedText = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        dosageButton.setTitle(selectedText, for: .normal)
    }
    // type button action
    @objc private func dosageButtonTapped() {
        isPickerOpen.toggle()
        dosagePickerView.isHidden = !isPickerOpen
        dosagePickerView.snp.updateConstraints { make in
            make.height.equalTo(isPickerOpen ? 250 : 0)
        }
        donePickerButton.isHidden = !isPickerOpen
    }
    
    @objc private func donePickerButtonTapped() {
        isPickerOpen = false
        dosagePickerView.isHidden = true
        dosagePickerView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        donePickerButton.isHidden = true
        // set выбранный элемент в кнопку "TypeButton"
        let selectedRow = dosagePickerView.selectedRow(inComponent: 0)
        let selectedText = self.pickerView(dosagePickerView, titleForRow: selectedRow, forComponent: 0)
        dosageButton.setTitle(selectedText, for: .normal)
    }
}
