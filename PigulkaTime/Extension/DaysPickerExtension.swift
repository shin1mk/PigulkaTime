//
//  DaysPickerExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 14.11.2023.
//

import UIKit
import UserNotifications

extension PillsViewController: DaysCustomTableCellDelegate {
    // MARK: - Days Picker
    func didSelectDays(cell: DaysCustomTableCell) {
        let pickerViewController = createPickerViewController()
        present(pickerViewController, animated: true, completion: nil)
    }

    private func createPickerViewController() -> UIViewController {
        let pickerViewController = UIViewController()
        let pickerView = createPickerView(for: pickerViewController)
        let okButton = createDaysOkButton(for: pickerViewController)

        pickerViewController.view.addSubview(pickerView)
        pickerViewController.view.addSubview(okButton)
        pickerViewController.modalPresentationStyle = .overCurrentContext

        return pickerViewController
    }

    private func createPickerView(for pickerViewController: UIViewController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 5 // For Type picker view
        pickerView.backgroundColor = .black
        pickerView.selectRow(0, inComponent: 0, animated: false)

        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)

        return pickerView
    }

    private func createDaysOkButton(for pickerViewController: UIViewController) -> UIButton {
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(daysOkButtonTapped(_:)), for: .touchUpInside)

        let bottomMargin: CGFloat = 30
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)

        return okButton
    }
    // daysOkButtonTapped
    @objc private func daysOkButtonTapped(_ sender: UIButton) {
        // Получите выбранные дни
        guard let selectedDays = selectedDays else {
            // Обработка случая, когда selectedDays равно nil
            print("Дни не выбраны.")
            dismiss(animated: true, completion: nil)
            return
        }
        // выбранный тип в typeLabel
        if let daysCell = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? DaysCustomTableCell {
            daysCell.setDaysText("\(selectedDays)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }

    private func getNotificationTrigger(forFrequency frequency: String, dateComponents: DateComponents) -> UNNotificationTrigger? {
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
    
     func scheduleNotifications(forDates dates: [Date], atTimes times: [String], withFrequency frequency: String) {
        let content = UNMutableNotificationContent()
        content.title = "PigulkaTime"
        let name = editingCell?.textField.text ?? "Time for pill"
        content.body = "Time for \(name) \(selectedDosage ?? "no dosage") \(selectedType ?? "no type")"
        // Добавляем виброотклик
        content.sound = .default
        content.sound = UNNotificationSound.default

        for (index, date) in dates.enumerated() {
            for time in times {
                let components = time.components(separatedBy: ":")
                guard components.count == 2 else {
                    print("Ошибка: Неверный формат времени - \(time)")
                    continue
                }
   
                guard let hour = Int(components[0]), let minute = Int(components[1]) else {
                    print("Ошибка: Не удалось преобразовать компоненты времени в целые числа - \(components)")
                    continue
                }

                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                dateComponents.hour = hour
                dateComponents.minute = minute

                if let trigger = getNotificationTrigger(forFrequency: frequency, dateComponents: dateComponents) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let notificationDate = Calendar.current.date(from: dateComponents)

                    if let notificationDate = notificationDate {
                        let formattedDate = dateFormatter.string(from: notificationDate)

                        let request = UNNotificationRequest(identifier: "\(index)-\(time)", content: content, trigger: trigger)

                        // Выводим информацию о дне, времени и частоте перед установкой уведомления
                        print("Уведомление будет установлено на дату \(formattedDate) в \(time) с частотой \(frequency)")

                        UNUserNotificationCenter.current().add(request) { (error) in
                            if let error = error {
                                print("Ошибка при установке уведомления: \(error.localizedDescription)")
                            } else {
                                print("Уведомление успешно установлено")
                            }
                        }
                    } else {
                        print("Ошибка: Не удалось создать дату уведомления для \(dateComponents)")
                    }
                } else {
                    print("Ошибка: Неподдерживаемая частота - \(frequency)")
                }
            }
        }
    }
}
