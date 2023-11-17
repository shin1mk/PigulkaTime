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
        guard let selectedFrequency = selectedFrequency else {
            print("No frequency selected.")
            dismiss(animated: true, completion: nil)
            return
        }

        print("Selected Frequency: \(selectedFrequency)")

        let frequencyInterval = getFrequencyInterval(for: selectedFrequency)
        print("frequencyInterval: \(frequencyInterval)")
        // Создаем триггер уведомления с заданным интервалом
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: frequencyInterval, repeats: true)
//        print("Notification scheduled successfully.")
        // выбранную частоту в frequencyLabel
        if let frequencyCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? FrequencyCustomTableCell {
            frequencyCell.setFrequencyText("\(selectedFrequency)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закрываем UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }

    private func getFrequencyInterval(for frequency: String) -> TimeInterval {
        switch frequency {
        case "Daily":
            return 24 * 60 * 60 // 24 часа в секундах
        case "Every Hour":
            return 60 * 60 // 1 час в секундах
        case "Every 2 hours":
            return 2 * 60 * 60 // 2 часа в секундах
        case "Every 3 hours":
            return 3 * 60 * 60 // 3 часа в секундах
        case "Every 4 hours":
            return 4 * 60 * 60 // 4 часа в секундах
        case "Every 6 hours":
            return 6 * 60 * 60 // 6 часов в секундах
        case "Every 8 hours":
            return 8 * 60 * 60 // 8 часов в секундах
        case "Every 12 hours":
            return 12 * 60 * 60 // 12 часов в секундах
        case "Every 2 days":
            return 2 * 24 * 60 * 60 // 2 дня в секундах
        case "Every 3 days":
            return 3 * 24 * 60 * 60 // 3 дня в секундах
        case "Every 4 days":
            return 4 * 24 * 60 * 60 // 4 дня в секундах
        case "Every 5 days":
            return 5 * 24 * 60 * 60 // 5 дней в секундах
        case "Every 6 days":
            return 6 * 24 * 60 * 60 // 6 дней в секундах
        case "Weekly":
            return 7 * 24 * 60 * 60 // 7 дней в секундах (неделя)
        case "Every 2 weeks":
            return 2 * 7 * 24 * 60 * 60 // 2 недели в секундах
        case "Every 3 weeks":
            return 3 * 7 * 24 * 60 * 60 // 3 недели в секундах
        case "Every 4 weeks":
            return 4 * 7 * 24 * 60 * 60 // 4 недели в секундах
        default:
            return 0
        }
    }

}

