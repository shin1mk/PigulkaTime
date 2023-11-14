//
//  StartPickerExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 14.11.2023.
//

import UIKit
import UserNotifications
//MARK: starting picker view
extension PillsViewController: StartCustomTableCellDelegate {
    func didSelectStart(cell: StartCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 6
        pickerView.backgroundColor = .black
        pickerView.reloadComponent(0) // 0 — это индекс компонента часов
        pickerView.reloadComponent(1) // 1 — это индекс компонента минут

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
        okButton.addTarget(self, action: #selector(startingOkButtonTapped(_:)), for: .touchUpInside)
        
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        // Добавьте кнопку в UIViewController
        pickerViewController.view.addSubview(okButton)
        // Отобразите UIViewController модально
        pickerViewController.modalPresentationStyle = .overCurrentContext
        present(pickerViewController, animated: true, completion: nil)
    }
    
//    @objc private func startingOkButtonTapped(_ sender: UIButton) {
//        // Получите выбранный тип из свойства selectedType
//        guard let selectedStart = selectedStart else {
//            print("No times selected.")
//            dismiss(animated: true, completion: nil)
//            return
//        }
//        // Выведите в консоль выбранный тип
//        print("Selected start at: \(selectedStart)")
//        // выбранный тип в typeLabel
//        if let typeCell = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? StartCustomTableCell {
//            typeCell.setStartText("\(selectedStart)")
//        }
//        // Снимите фокус с текстового поля
//        editingCell?.textField.resignFirstResponder()
//        // Закройте UIViewController при нажатии кнопки "OK"
//        dismiss(animated: true, completion: nil)
//    }
    @objc private func startingOkButtonTapped(_ sender: UIButton) {
        // Получите выбранное время из свойства selectedStarting
        guard let selectedStart = selectedStart else {
            print("No time selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        
        // Выведите в консоль выбранное время
        print("Selected start at: \(selectedStart)")

        // Установите календарь и текущую дату
        let calendar = Calendar.current
        let currentDate = Date()
        
        // Разделите строку времени
        let timeComponents = selectedStart.components(separatedBy: ":")
        guard let hour = Int(timeComponents[0]), let minute = Int(timeComponents[1]) else {
            print("Invalid time format.")
            dismiss(animated: true, completion: nil)
            return
        }
        
        // Создайте новую дату с текущими годом, месяцем и днем, а также выбранными часами и минутами
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = 0 // Установите секунды на 0, если необходимо
        let selectedDate = calendar.date(from: dateComponents)
        
        // Проверьте, не выбрано ли время в прошлом
        if selectedDate ?? Date() < currentDate {
            print("Selected time is in the past. Scheduling for the next day.")
            
            // Добавьте 24 часа к текущей дате
            let nextDayDate = currentDate.addingTimeInterval(24 * 60 * 60)
            
            // Создайте новую дату с выбранными часами и минутами на следующий день
            var nextDayDateComponents = calendar.dateComponents([.year, .month, .day], from: nextDayDate)
            nextDayDateComponents.hour = hour
            nextDayDateComponents.minute = minute
            nextDayDateComponents.second = 0
            let nextDaySelectedDate = calendar.date(from: nextDayDateComponents)
            
            // Запланируйте уведомление
            scheduleNotification(at: nextDaySelectedDate ?? Date())
            
            // выбранное время в typeLabel
            if let typeCell = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? StartCustomTableCell {
                typeCell.setStartText("\(selectedStart)")
            }
            
            // Снимите фокус с текстового поля
            editingCell?.textField.resignFirstResponder()
            
            // Закройте UIViewController при нажатии кнопки "OK"
            dismiss(animated: true, completion: nil)
            return
        }

        
        // Запланируйте уведомление
        scheduleNotification(at: selectedDate ?? Date())

        // выбранное время в typeLabel
        if let typeCell = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? StartCustomTableCell {
            typeCell.setStartText("\(selectedStart)")
        }
        
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
    // Метод для запланированного уведомления
    private func scheduleNotification(at date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "PigulkaTime"
        
        let name = editingCell?.textField.text ?? "Time to pigulka"
        content.body = "Time for \(name)"
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "medicationReminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            } else {
                print("Notification scheduled successfully for time: \(components.hour ?? 0):\(components.minute ?? 0)")
            }
        }
    }
}
