//
//  DosagePickerExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 14.11.2023.
//

import UIKit
//MARK: Dosage picker view
extension PillsViewController: DosageCustomTableCellDelegate {
    func didSelectDosage(cell: DosageCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 2 // Для Type picker view
        pickerView.backgroundColor = .black
        // Установите размеры UIPickerView
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        // Добавьте UIPickerView в UIViewController
        pickerViewController.view.addSubview(pickerView)
        // Создайте кнопку "OK" для закрытия пикера
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(dosageOkButtonTapped(_:)), for: .touchUpInside)
        
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        // Добавьте кнопку в UIViewController
        pickerViewController.view.addSubview(okButton)
        // Отобразите UIViewController модально
        pickerViewController.modalPresentationStyle = .overCurrentContext
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc private func dosageOkButtonTapped(_ sender: UIButton) {
        // Получите выбранный тип из свойства selectedType
        guard let selectedDosage = selectedDosage else {
            print("No type selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        // Выведите в консоль выбранный тип
        print("Selected Dosage: \(selectedDosage)")
        // выбранный тип в typeLabel
        if let typeCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? DosageCustomTableCell {
            typeCell.setDosageText("\(selectedDosage)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
}
