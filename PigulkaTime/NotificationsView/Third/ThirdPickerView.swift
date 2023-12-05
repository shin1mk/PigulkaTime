//
//  ThirdPickerView.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 02.12.2023.
//

import UIKit
import UserNotifications

extension NotificationsViewController {
    // MARK: - Time Picker
    func didSelectThirdTime(cell: ThirdCustomTableCell) {
        let pickerViewController = createPickerViewController()
        present(pickerViewController, animated: true, completion: nil)
    }
    
    private func createPickerViewController() -> UIViewController {
        let pickerViewController = UIViewController()
        let pickerView = createPickerView(for: pickerViewController)
        let okButton = createThirdTimeOkButton(for: pickerViewController)
        
        pickerViewController.view.addSubview(pickerView)
        pickerViewController.view.addSubview(okButton)
        pickerViewController.modalPresentationStyle = .overCurrentContext
        
        return pickerViewController
    }
    
    private func createPickerView(for pickerViewController: UIViewController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 2
        pickerView.backgroundColor = .black
        pickerView.selectRow(0, inComponent: 0, animated: false)
        
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        
        return pickerView
    }
    
    private func createThirdTimeOkButton(for pickerViewController: UIViewController) -> UIButton {
        let okButton = UIButton(type: .system)
        okButton.setTitle("Done", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 20)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(thirdOkButtonTapped(_:)), for: .touchUpInside)
        
        let bottomMargin: CGFloat = 30
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        
        return okButton
    }
    // кнопка нажата
    @objc private func thirdOkButtonTapped(_ sender: UIButton) {
        // Обновляем ячейку, например, для первой строки таблицы
        let indexPath = IndexPath(row: 2, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? ThirdCustomTableCell {
            // Обновляем текст в ячейке с выбранным временем
            cell.setThirdTimeText(String(format: "%02d:%02d", ThirdSelectedHour, ThirdSelectedMinute))
            // Устанавливаем свитчер включенным
            cell.switchControl.isOn = true
            // Сохраняем состояние свитча в UserDefaults
            cell.saveSwitchState(isOn: true)
            // Обновляем UI после установки времени
            cell.updateUIForSwitchState(isOn: true)
        }
        // Закрываем пикер вью
        dismiss(animated: true, completion: nil)
        // Создаем уведомление
        createThirdNotification()
        // Сохраняем данные в UserDefaults
        saveThirdNotificationTime()
    }
    // создаем уведомление
    func createThirdNotification() {
        // Создаем объект UNUserNotificationCenter
        let center = UNUserNotificationCenter.current()
        // Создаем экземпляр класса UNMutableNotificationContent для настройки уведомления
        let content = UNMutableNotificationContent()
        content.title = "PigulkaTime"
        content.body = "Time to take your pills!"
        content.sound = .default
        // Установка текущей даты и времени с учетом локального времени устройства
        let now = Date()
        // Установка выбранного времени
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        dateComponents.hour = ThirdSelectedHour
        dateComponents.minute = ThirdSelectedMinute
        // Если выбранное время уже прошло сегодня, устанавливаем триггер на следующий день
        if let triggerDate = Calendar.current.date(from: dateComponents) {
            print("3 Уведомление будет запущено для времени: \(triggerDate)")
            // Создаем триггер на следующий день с тем же временем
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: triggerDate), repeats: true)
            // Уникальный идентификатор для уведомления
            let notificationIdentifier = "ThirdNotification"
            // Создаем запрос на уведомление
            let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
            // Добавляем запрос в центр уведомлений
            center.add(request) { (error) in
                if let error = error {
                    print("3 Ошибка при добавлении уведомления: \(error.localizedDescription)")
                } else {
                    print("Уведомление успешно добавлено для следующего повторения.")
                }
            }
        } else {
            print("3 Не удалось создать объект Date из DateComponents")
        }
    }
    // отмена уведомлений
    func cancelThirdNotification() {
        DispatchQueue.main.async {
            let notificationCenter = UNUserNotificationCenter.current()
            // Уникальный идентификатор для уведомления
            let notificationIdentifier = "ThirdNotification"
            // Удаляем уведомление с указанным идентификатором
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
            print("Notification removed with identifier: \(notificationIdentifier)")
        }
    }
    // сохраняем время в userdefault
    private func saveThirdNotificationTime() {
        // Сохранение данных в UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(ThirdSelectedHour, forKey: "ThirdSelectedHour")
        defaults.set(ThirdSelectedMinute, forKey: "ThirdSelectedMinute")
        // Вывод в консоль для отслеживания
        print("3 Данные успешно сохранены:")
        print("ThirdSelectedHour: \(ThirdSelectedHour)")
        print("ThirdSelectedMinute: \(ThirdSelectedMinute)")
    }
} // end

