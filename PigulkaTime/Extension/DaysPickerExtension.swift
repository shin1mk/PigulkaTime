//
//  DaysPickerExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 14.11.2023.
//

import UIKit
import UserNotifications
//MARK: Days picker view
extension PillsViewController: DaysCustomTableCellDelegate {
    func didSelectDays(cell: DaysCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 4 // Для Type picker view
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
        okButton.addTarget(self, action: #selector(daysOkButtonTapped(_:)), for: .touchUpInside)
        
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        // Добавьте кнопку в UIViewController
        pickerViewController.view.addSubview(okButton)
        // Отобразите UIViewController модально
        pickerViewController.modalPresentationStyle = .overCurrentContext
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc private func daysOkButtonTapped(_ sender: UIButton) {
        // Получите выбранные дни
        guard let selectedDaysString = selectedDays else {
            // Обработка случая, когда selectedDays равно nil
            print("Дни не выбраны.")
            dismiss(animated: true, completion: nil)
            return
        }
        
        // Очистка строки от лишних символов и преобразование в Int
        let cleanedSelectedDaysString = selectedDaysString.replacingOccurrences(of: "days", with: "").trimmingCharacters(in: .whitespaces)
        guard let selectedDays = Int(cleanedSelectedDaysString) else {
            print("Invalid or non-integer value for selectedDays: \(cleanedSelectedDaysString)")
            return
        }
        
        // Выведите в консоль выбранный тип
        print("Selected days: \(selectedDays)")
        // выбранный тип в typeLabel
        if let typeCell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? DaysCustomTableCell {
            typeCell.setDaysText("\(selectedDays)")
        }
        
        // Получите выбранное время
        guard let selectedStartTime = selectedStart else {
            print("Time not selected.")
            return
        }
        
        let startDate = Date() // Используйте вашу начальную дату
        let dates = (0..<selectedDays).map { Calendar.current.date(byAdding: .day, value: $0, to: startDate) ?? Date() }
        scheduleNotifications(forDates: dates, atTimes: [selectedStartTime])
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
    
    private func scheduleNotifications(forDates dates: [Date], atTimes times: [String]) {
        let content = UNMutableNotificationContent()
        content.title = "Время принять таблетку"
        content.body = "Не забудьте принять свои таблетки."

        for (index, date) in dates.enumerated() {
            for time in times {
                let components = time.components(separatedBy: ":")
                guard components.count == 2 else {
                    print("Error: Invalid time format - \(time)")
                    continue
                }

                guard let hour = Int(components[0]), let minute = Int(components[1]) else {
                    print("Error: Unable to convert time components to integers - \(components)")
                    continue
                }

                var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
                dateComponents.hour = hour
                dateComponents.minute = minute

                if let notificationDate = Calendar.current.date(from: dateComponents) {
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

                    let request = UNNotificationRequest(identifier: "\(index)-\(time)", content: content, trigger: trigger)

                    // Выводим информацию о дне и времени перед установкой уведомления
                    print("Setting notification for date \(notificationDate) at time \(time)")

                    UNUserNotificationCenter.current().add(request) { (error) in
                        if let error = error {
                            print("Ошибка при установке уведомления: \(error.localizedDescription)")
                        } else {
                            print("Уведомление успешно установлено")
                        }
                    }
                } else {
                    print("Error: Unable to create notification date for \(dateComponents)")
                }
            }
        }
    }


}
