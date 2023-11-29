//
//  SecondPickerView.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit
import UserNotifications


extension NotificationsViewController {
    // MARK: - Time Picker
    func didSelectSecondTime(cell: SecondCustomTableCell) {
        let pickerViewController = createPickerViewController()
        present(pickerViewController, animated: true, completion: nil)
    }
    
    private func createPickerViewController() -> UIViewController {
        let pickerViewController = UIViewController()
        let pickerView = createPickerView(for: pickerViewController)
        let okButton = createSecondTimeOkButton(for: pickerViewController)
        
        pickerViewController.view.addSubview(pickerView)
        pickerViewController.view.addSubview(okButton)
        pickerViewController.modalPresentationStyle = .overCurrentContext
        
        return pickerViewController
    }
    
    private func createPickerView(for pickerViewController: UIViewController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 1 // For Type picker view
        pickerView.backgroundColor = .black
        pickerView.selectRow(0, inComponent: 0, animated: false)
        
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        
        return pickerView
    }
    
    private func createSecondTimeOkButton(for pickerViewController: UIViewController) -> UIButton {
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(secondOkButtonTapped(_:)), for: .touchUpInside)
        
        let bottomMargin: CGFloat = 30
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        
        return okButton
    }
    
    @objc private func secondOkButtonTapped(_ sender: UIButton) {
        // Обновляем ячейку, например, для первой строки таблицы
        let indexPath = IndexPath(row: 1, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? SecondCustomTableCell {
            // Обновляем текст в ячейке с выбранным временем
            cell.setSecondTimeText(String(format: "%02d:%02d", selectedHour, selectedMinute))
        }

        // Закрываем пикер вью
        dismiss(animated: true, completion: nil)

        // Создаем объект UNUserNotificationCenter
        let center = UNUserNotificationCenter.current()

        // Создаем экземпляр класса UNMutableNotificationContent для настройки уведомления
        let content = UNMutableNotificationContent()
        content.title = "PigulkaTime"
        content.body = "SecondNotification!"
        content.sound = .default

        // Создаем экземпляр класса UNCalendarNotificationTrigger для триггера по времени
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: Date())
        dateComponents.hour = selectedHour
        dateComponents.minute = selectedMinute

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // Создаем запрос на уведомление
        let request = UNNotificationRequest(identifier: "SecondNotification", content: content, trigger: trigger)

        // Добавляем запрос в центр уведомлений
        center.add(request) { (error) in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            } else {
                print("SecondNotification.swift")
            }
        }
        // Выводим в консоль время уведомления
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let notificationTime = trigger.nextTriggerDate() {
            let formattedNotificationTime = dateFormatter.string(from: notificationTime)
            print("второе Уведомление запланировано на время: \(formattedNotificationTime)")
        }
    }
}
