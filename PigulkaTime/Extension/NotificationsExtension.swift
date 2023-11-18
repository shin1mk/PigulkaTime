//
//  NotificationsExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 18.11.2023.
//

import UIKit
import UserNotifications

extension PillsViewController {
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
