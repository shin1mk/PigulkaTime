//
//  FrequencyPickerExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 14.11.2023.
//

import UIKit

extension PillsViewController: FrequencyCustomTableCellDelegate {
    // MARK: - Frequency Picker
    func didSelectFrequency(cell: FrequencyCustomTableCell) {
        let pickerViewController = createPickerViewController()
        present(pickerViewController, animated: true, completion: nil)
    }

    private func createPickerViewController() -> UIViewController {
        let pickerViewController = UIViewController()
        let pickerView = createPickerView(for: pickerViewController)
        let okButton = createFrequencyOkButton(for: pickerViewController)

        pickerViewController.view.addSubview(pickerView)
        pickerViewController.view.addSubview(okButton)
        pickerViewController.modalPresentationStyle = .overCurrentContext

        return pickerViewController
    }

    private func createPickerView(for pickerViewController: UIViewController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 3 // For Type picker view
        pickerView.backgroundColor = .black
        pickerView.selectRow(0, inComponent: 0, animated: false)

        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)

        return pickerView
    }

    private func createFrequencyOkButton(for pickerViewController: UIViewController) -> UIButton {
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(frequencyOkButtonTapped(_:)), for: .touchUpInside)

        let bottomMargin: CGFloat = 30
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)

        return okButton
    }
    // MARK: - Ok Button Action
    @objc private func frequencyOkButtonTapped(_ sender: UIButton) {
        // Получите выбранный тип из свойства selectedType
        guard let selectedFrequency = selectedFrequency else {
            print("No type selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        // Проверьте, было ли выбрано время, если нет, установите значение по умолчанию (0)
        let selectedTime = selectedTime ?? "0"
        
        print("Selected Time: \(selectedTime)")
        print("Selected Frequency: \(selectedFrequency)")
        // выбранную частоту в frequencyLabel
        if let frequencyCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? FrequencyCustomTableCell {
            frequencyCell.setFrequencyText("\(selectedFrequency)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
    
    func getNotificationTrigger(forFrequency frequency: String, dateComponents: DateComponents) -> UNNotificationTrigger? {
        switch frequency {
        case "Daily":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        case "Every Hour":
            return UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
        case "Every 2 hours":
            return UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: true)
        case "Every 3 hours":
            return UNTimeIntervalNotificationTrigger(timeInterval: 10800, repeats: true)
        case "Every 4 hours":
            return UNTimeIntervalNotificationTrigger(timeInterval: 14400, repeats: true)
        case "Every 6 hours":
            return UNTimeIntervalNotificationTrigger(timeInterval: 21600, repeats: true)
        case "Every 8 hours":
            return UNTimeIntervalNotificationTrigger(timeInterval: 28800, repeats: true)
        case "Every 12 hours":
            return UNTimeIntervalNotificationTrigger(timeInterval: 43200, repeats: true)
        case "Every 2 days":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        case "Every 3 days":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        case "Every 4 days":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        case "Every 5 days":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        case "Every 6 days":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        case "Weekly":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        case "Every 2 weeks":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        case "Every 3 weeks":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        case "Every 4 weeks":
            return UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        default:
            return nil
        }
    }
}
