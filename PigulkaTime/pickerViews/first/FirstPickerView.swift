//
//  FirstPickerView.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit
import UserNotifications

extension NotificationsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Time Picker
    func didSelectFirstTime(cell: FirstCustomTableCell) {
        let pickerViewController = createPickerViewController()
        present(pickerViewController, animated: true, completion: nil)
    }
    
    private func createPickerViewController() -> UIViewController {
        let pickerViewController = UIViewController()
        let pickerView = createPickerView(for: pickerViewController)
        let okButton = createFirstTimeOkButton(for: pickerViewController)
        
        pickerViewController.view.addSubview(pickerView)
        pickerViewController.view.addSubview(okButton)
        pickerViewController.modalPresentationStyle = .overCurrentContext
        
        return pickerViewController
    }
    
    private func createPickerView(for pickerViewController: UIViewController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 0 // For Type picker view
        pickerView.backgroundColor = .black
        pickerView.selectRow(0, inComponent: 0, animated: false)
        
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        
        return pickerView
    }
    
    private func createFirstTimeOkButton(for pickerViewController: UIViewController) -> UIButton {
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(firstOkButtonTapped(_:)), for: .touchUpInside)
        
        let bottomMargin: CGFloat = 30
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        
        return okButton
    }
    
//    @objc private func firstOkButtonTapped(_ sender: UIButton) {
//        // Обновляем ячейку, например, для первой строки таблицы
//        let indexPath = IndexPath(row: 0, section: 0)
//        if let cell = tableView.cellForRow(at: indexPath) as? FirstCustomTableCell {
//            // Обновляем текст в ячейке с выбранным временем
//            cell.setFirstTimeText(String(format: "%02d:%02d", selectedHour, selectedMinute))
//        }
//
//        // Закрываем пикер вью
//        dismiss(animated: true, completion: nil)
//
//        // Создаем объект UNUserNotificationCenter
//        let center = UNUserNotificationCenter.current()
//
//        // Создаем экземпляр класса UNMutableNotificationContent для настройки уведомления
//        let content = UNMutableNotificationContent()
//        content.title = "PigulkaTime"
//        content.body = "FirstNotification!"
//        content.sound = .default
//
//        // Создаем экземпляр класса UNCalendarNotificationTrigger для триггера по времени
//        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
//        dateComponents.hour = selectedHour
//        dateComponents.minute = selectedMinute
//
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//        // Создаем запрос на уведомление
//        let request = UNNotificationRequest(identifier: "firstNotification", content: content, trigger: trigger)
//
//        // Добавляем запрос в центр уведомлений
//        center.add(request) { (error) in
//            if let error = error {
//                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
//            } else {
//                print("FirstPickerView.swift")
//            }
//        }
//        // Выводим в консоль время уведомления
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//        if let notificationTime = trigger.nextTriggerDate() {
//            let formattedNotificationTime = dateFormatter.string(from: notificationTime)
//            print("первое Уведомление запланировано на время: \(formattedNotificationTime)")
//        }
//    }
    
//    @objc private func firstOkButtonTapped(_ sender: UIButton) {
//            // Обновляем ячейку, например, для первой строки таблицы
//            let indexPath = IndexPath(row: 0, section: 0)
//            if let cell = tableView.cellForRow(at: indexPath) as? FirstCustomTableCell {
//                // Обновляем текст в ячейке с выбранным временем
//                cell.setFirstTimeText(String(format: "%02d:%02d", selectedHour, selectedMinute))
//            }
//
//            // Закрываем пикер вью
//            dismiss(animated: true, completion: nil)
//
//            // Создаем объект UNUserNotificationCenter
//            let center = UNUserNotificationCenter.current()
//
//            // Создаем экземпляр класса UNMutableNotificationContent для настройки уведомления
//            let content = UNMutableNotificationContent()
//            content.title = "PigulkaTime"
//            content.body = "FirstNotification!"
//            content.sound = .default
//
//            // Создаем экземпляр класса UNCalendarNotificationTrigger для триггера по времени
//            var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: Date())
//            dateComponents.hour = selectedHour
//            dateComponents.minute = selectedMinute
//
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
//
//            // Создаем запрос на уведомление
//            let request = UNNotificationRequest(identifier: "firstNotification", content: content, trigger: trigger)
//
//            // Добавляем запрос в центр уведомлений
//            center.add(request) { (error) in
//                if let error = error {
//                    print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
//                } else {
//                    print("FirstPickerView.swift")
//                }
//            }
//
//            // Выводим в консоль время уведомления
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//            if let notificationTime = trigger.nextTriggerDate() {
//                let formattedNotificationTime = dateFormatter.string(from: notificationTime)
//                print("Уведомление запланировано на время: \(formattedNotificationTime)")
//            }
//        }
//    @objc private func firstOkButtonTapped(_ sender: UIButton) {
//        let daysArray = ["1 day", "2 days", "3 days", "4 days", "5 days", "6 days", "1 week", "10 days", "2 weeks", "1 month", "2 months", "3 months"]
//        let daysIntervals: [TimeInterval] = [1 * 24 * 60 * 60, 2 * 24 * 60 * 60, 3 * 24 * 60 * 60, 4 * 24 * 60 * 60, 5 * 24 * 60 * 60, 6 * 24 * 60 * 60, 7 * 24 * 60 * 60, 10 * 24 * 60 * 60, 14 * 24 * 60 * 60, 30 * 24 * 60 * 60, 60 * 24 * 60 * 60, 90 * 24 * 60 * 60]
//
//        // Обновляем ячейку, например, для первой строки таблицы
//        let indexPath = IndexPath(row: 0, section: 0)
//        if let cell = tableView.cellForRow(at: indexPath) as? FirstCustomTableCell {
//            // Обновляем текст в ячейке с выбранным временем
//            cell.setFirstTimeText(String(format: "%02d:%02d", selectedHour, selectedMinute))
//        }
//
//        // Закрываем пикер вью
//        dismiss(animated: true, completion: nil)
//
//        // Создаем объект UNUserNotificationCenter
//        let center = UNUserNotificationCenter.current()
//
//        // Создаем экземпляр класса UNMutableNotificationContent для настройки уведомления
//        let content = UNMutableNotificationContent()
//        content.title = "PigulkaTime"
//        content.body = "Daily Notification!"
//        content.sound = .default
//
//        // Создаем экземпляр класса UNCalendarNotificationTrigger для триггера по времени
//        let calendar = Calendar.current
//        var dateComponents = DateComponents()
//        dateComponents.hour = selectedHour
//        dateComponents.minute = selectedMinute
//
//        // Создаем запрос на уведомление для каждого выбранного дня
//        for daysInterval in daysIntervals {
//            let triggerDate = calendar.date(byAdding: .second, value: Int(daysInterval), to: Date())
//            if let triggerDate = triggerDate {
//                let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: triggerDate), repeats: false)
//
//                // Создаем запрос на уведомление
//                let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
//
//                // Добавляем запрос в центр уведомлений
//                center.add(request) { (error) in
//                    if let error = error {
//                        print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
//                    } else {
//                        print("Daily notification added successfully.")
//                    }
//                }
//
//                // Выводим в консоль время уведомления
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//                let formattedNotificationTime = dateFormatter.string(from: triggerDate)
//                print("Уведомление запланировано на время: \(formattedNotificationTime)")
//            }
//        }
//    }
//    @objc private func firstOkButtonTapped(_ sender: UIButton) {
//        let daysArray = ["1 day", "2 days", "3 days", "4 days", "5 days", "6 days", "1 week", "10 days", "2 weeks", "1 month", "2 months", "3 months"]
//        let daysIntervals: [TimeInterval] = [1 * 24 * 60 * 60, 2 * 24 * 60 * 60, 3 * 24 * 60 * 60, 4 * 24 * 60 * 60, 5 * 24 * 60 * 60, 6 * 24 * 60 * 60, 7 * 24 * 60 * 60, 10 * 24 * 60 * 60, 14 * 24 * 60 * 60, 30 * 24 * 60 * 60, 60 * 24 * 60 * 60, 90 * 24 * 60 * 60]
//
//        // Обновляем ячейку, например, для первой строки таблицы
//        let indexPath = IndexPath(row: 0, section: 0)
//        if let cell = tableView.cellForRow(at: indexPath) as? FirstCustomTableCell {
//            // Обновляем текст в ячейке с выбранным временем
//            cell.setFirstTimeText(String(format: "%02d:%02d", selectedHour, selectedMinute))
//        }
//
//        // Закрываем пикер вью
//        dismiss(animated: true, completion: nil)
//
//        // Создаем объект UNUserNotificationCenter
//        let center = UNUserNotificationCenter.current()
//
//        // Создаем экземпляр класса UNMutableNotificationContent для настройки уведомления
//        let content = UNMutableNotificationContent()
//        content.title = "PigulkaTime"
//        content.body = "Daily Notification!"
//        content.sound = .default
//
//        // Создаем экземпляр класса Date для выбранного времени пользователя
//        let calendar = Calendar.current
//        var dateComponents = DateComponents()
//        dateComponents.hour = selectedHour
//        dateComponents.minute = selectedMinute
//
//        // Создаем запрос на уведомление для каждого выбранного дня
//        for daysInterval in daysIntervals {
//            let triggerDate = calendar.date(byAdding: .second, value: Int(daysInterval), to: Date())
//            if let triggerDate = triggerDate {
//                let adjustedDate = calendar.date(bySettingHour: selectedHour, minute: selectedMinute, second: 0, of: triggerDate)!
//
//                let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: adjustedDate), repeats: false)
//
//                // Создаем запрос на уведомление
//                let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
//
//                // Добавляем запрос в центр уведомлений
//                center.add(request) { (error) in
//                    if let error = error {
//                        print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
//                    } else {
//                        print("Daily notification added successfully.")
//                    }
//                }
//
//                // Выводим в консоль время уведомления
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
//                let formattedNotificationTime = dateFormatter.string(from: adjustedDate)
//                print("Уведомление запланировано на время: \(formattedNotificationTime)")
//            }
//        }
//    }
    @objc private func firstOkButtonTapped(_ sender: UIButton) {
        // Обновляем ячейку, например, для первой строки таблицы
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? FirstCustomTableCell {
            // Обновляем текст в ячейке с выбранным временем
            cell.setFirstTimeText(String(format: "%02d:%02d", selectedHour, selectedMinute))
        }
        
        // Закрываем пикер вью
        dismiss(animated: true, completion: nil)
        
        // Создаем объект UNUserNotificationCenter
        let center = UNUserNotificationCenter.current()
        
        // Создаем экземпляр класса UNMutableNotificationContent для настройки уведомления
        let content = UNMutableNotificationContent()
        content.title = "PigulkaTime"
        content.body = "Daily Notification!"
        content.sound = .default
        
        // Создаем экземпляр класса Date для выбранного времени пользователя
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = selectedHour
        dateComponents.minute = selectedMinute
        
        let firstTriggerDate = getNextTriggerDate(selectedHour: selectedHour, selectedMinute: selectedMinute)

        // Получаем количество дней из выбранной строки
        // Получаем выбранный интервал времени
        guard let selectedDaysString = daysArray.first(where: { $0 == selectedValue }), let selectedDays = Int(selectedDaysString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()) else {
            return
        }
        // Создаем запрос на уведомление для каждого выбранного дня
        for daysInterval in 0..<selectedDays {
//            let triggerDate = calendar.date(byAdding: .second, value: Int(daysInterval) * Int(daysIntervals[1]), to: Date())
//            let triggerDate = calendar.date(byAdding: .day, value: daysInterval, to: Date())
            let triggerDate = calendar.date(byAdding: .day, value: daysInterval, to: firstTriggerDate)

            if let triggerDate = triggerDate {
                let adjustedDate = calendar.date(bySettingHour: selectedHour, minute: selectedMinute, second: 0, of: triggerDate)!
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.hour, .minute], from: adjustedDate), repeats: false)
                
                // Создаем запрос на уведомление
                let request = UNNotificationRequest(identifier: "dailyNotification", content: content, trigger: trigger)
                
                // Добавляем запрос в центр уведомлений
                center.add(request) { (error) in
                    if let error = error {
                        print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
                    } else {
                        print("Daily notification added successfully.")
                    }
                }
                
                // Выводим в консоль время уведомления
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
                let formattedNotificationTime = dateFormatter.string(from: adjustedDate)
                print("Уведомление запланировано на время: \(formattedNotificationTime)")
            }
        }
    }

    func getNextTriggerDate(selectedHour: Int, selectedMinute: Int) -> Date {
        let calendar = Calendar.current
        let currentDate = Date()

        // Создаем экземпляр класса Date для выбранного времени пользователя сегодня
        var todayComponents = DateComponents()
        todayComponents.hour = selectedHour
        todayComponents.minute = selectedMinute
        let todayTriggerDate = calendar.date(bySettingHour: selectedHour, minute: selectedMinute, second: 0, of: currentDate)!

        // Если выбранное время уже прошло сегодня, увеличиваем дату на 1 день
        let firstTriggerDate = todayTriggerDate > currentDate ? todayTriggerDate : calendar.date(byAdding: .day, value: 1, to: todayTriggerDate)!

        return firstTriggerDate
    }


}
