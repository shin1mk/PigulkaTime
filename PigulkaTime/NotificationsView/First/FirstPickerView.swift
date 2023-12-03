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
        pickerView.tag = 0
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
    // кнопка нажата
    @objc private func firstOkButtonTapped(_ sender: UIButton) {
        // Обновляем ячейку, например, для первой строки таблицы
        let indexPath = IndexPath(row: 0, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) as? FirstCustomTableCell {
            // Обновляем текст в ячейке с выбранным временем
            cell.setFirstTimeText(String(format: "%02d:%02d", FirstSelectedHour, FirstSelectedMinute))
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
        createFirstNotification()
        // Сохраняем данные в UserDefaults
        saveFirstNotificationTime()
    }
    // создаем уведомление
    func createFirstNotification() {
        // Создаем объект UNUserNotificationCenter
        let center = UNUserNotificationCenter.current()
        // Создаем экземпляр класса UNMutableNotificationContent для настройки уведомления
        let content = UNMutableNotificationContent()
        content.title = "PigulkaTime"
        content.body = "First notification!"
        content.sound = .default
        // Установка текущей даты и времени с учетом локального времени устройства
        let now = Date()
        // Установка выбранного времени
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        dateComponents.hour = FirstSelectedHour
        dateComponents.minute = FirstSelectedMinute
        // Если выбранное время уже прошло сегодня, увеличиваем день на 1
        if let triggerDate = Calendar.current.date(from: dateComponents), triggerDate <= now {
            dateComponents.day! += 1
        }
        // Создание объекта Date на основе DateComponents
        if let triggerDate = Calendar.current.date(from: dateComponents) {
            print("1 Уведомление будет запущено для времени: \(triggerDate)")
            // Создаем запрос на уведомление с повторением каждый день
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            // Уникальный идентификатор для уведомления
            let notificationIdentifier = "FirstNotification"
            // Создаем запрос на уведомление
            let request = UNNotificationRequest(identifier: notificationIdentifier, content: content, trigger: trigger)
            // Добавляем запрос в центр уведомлений
            center.add(request) { (error) in
                if let error = error {
                    print("1 Ошибка при добавлении уведомления: \(error.localizedDescription)")
                } else {
                    print("First notification added successfully with identifier: \(notificationIdentifier)")
                }
            }
        } else {
            print("1 Не удалось создать объект Date из DateComponents")
        }
    }
    // сохраняем время в userdefault
    private func saveFirstNotificationTime() {
        // Сохранение данных в UserDefaults
        let defaults = UserDefaults.standard
        defaults.set(FirstSelectedHour, forKey: "FirstSelectedHour")
        defaults.set(FirstSelectedMinute, forKey: "FirstSelectedMinute")
        // Вывод в консоль для отслеживания
        print("1 Данные успешно сохранены:")
        print("FirstSelectedHour: \(FirstSelectedHour)")
        print("FirstSelectedMinute: \(FirstSelectedMinute)")
    }
    // отмена уведомлений
    func cancelFirstNotification() {
        DispatchQueue.main.async {
            let notificationCenter = UNUserNotificationCenter.current()
            // Уникальный идентификатор для уведомления
            let notificationIdentifier = "FirstNotification"
            // Удаляем уведомление с указанным идентификатором
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationIdentifier])
            print("Notification removed with identifier: \(notificationIdentifier)")
        }
    }
} // end

