//
//  PillsViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 08.11.2023.
//

import SnapKit
import UIKit

protocol PillsViewControllerDelegate: AnyObject {
    func pillsViewController(_ controller: PillsViewController, didAddPill pill: Pill)
}

final class PillsViewController: UIViewController, UITextFieldDelegate {
    weak var delegate: PillsViewControllerDelegate?

    private var isPickerOpen = false
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Add pill"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextHeavy(ofSize: 30)
        return titleLabel
    }()
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.SFUITextHeavy(ofSize: 20)
        saveButton.setTitleColor(.white, for: .normal)
        return saveButton
    }()
    private let drugLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Drug name"
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextRegular(ofSize: 18)
        return titleLabel
    }()
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.borderStyle = .roundedRect
        textField.font = UIFont.SFUITextRegular(ofSize: 18)
        textField.returnKeyType = .done
        return textField
    }()
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
    private let pickerView: UIPickerView = {
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
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTarget()
        setupDelegates()
    }
    //MARK: Methods
    private func setupConstraints() {
        view.backgroundColor = .black
        // save button
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-15)
        }
        // titleLabel
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        // drug label
        view.addSubview(drugLabel)
        drugLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
        }
        // drug text
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(drugLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        // type label
        view.addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
        }
        // type button
        view.addSubview(typeButton)
        typeButton.snp.makeConstraints { make in
            make.top.equalTo(typeLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }
        // type picker view
        view.addSubview(pickerView)
        pickerView.isHidden = true
        pickerView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(0)
        }
        // done picker view button
        view.addSubview(donePickerButton)
        donePickerButton.isHidden = true
        donePickerButton.snp.makeConstraints { make in
            make.bottom.equalTo(pickerView.snp.top).offset(100)
            make.trailing.equalToSuperview().offset(-15)
        }
    }
    // targets
    private func setupTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        typeButton.addTarget(self, action: #selector(typeButtonTapped), for: .touchUpInside)
        donePickerButton.addTarget(self, action: #selector(donePickerButtonTapped), for: .touchUpInside)
    }
    // delegates
    private func setupDelegates() {
        textField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    // save button
    @objc private func saveButtonTapped() {
        guard let enteredText = textField.text, !enteredText.isEmpty else {
            return // Не добавлять пустой текст
        }

        let newPill = Pill(name: enteredText, dosage: "", type: "", isEditable: true)
        delegate?.pillsViewController(self, didAddPill: newPill)
        // Закрыть текущий PillsViewController
        dismiss(animated: true, completion: nil)
    }
} // end
//MARK: Type Pills
extension PillsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        pickerView.isHidden = !isPickerOpen
        pickerView.snp.updateConstraints { make in
            make.height.equalTo(isPickerOpen ? 300 : 0)
        }
        donePickerButton.isHidden = !isPickerOpen
    }
    
    @objc private func donePickerButtonTapped() {
        isPickerOpen = false
        pickerView.isHidden = true
        pickerView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        donePickerButton.isHidden = true
        // set выбранный элемент в кнопку "TypeButton"
        let selectedRow = pickerView.selectedRow(inComponent: 0)
        let selectedText = self.pickerView(pickerView, titleForRow: selectedRow, forComponent: 0)
        typeButton.setTitle(selectedText, for: .normal)
    }
}
//MARK: Keyboard
extension PillsViewController {
    // Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Закрыть клавиатуру
        return true
    }
}
