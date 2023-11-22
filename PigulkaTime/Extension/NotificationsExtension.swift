//
//  NotificationsExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 18.11.2023.
//

import UIKit
import UserNotifications


extension PillsViewController {
    func scheduleNotifications(forDates dates: [Date], atTimes times: [String], withFrequency frequency: String, notificationIdentifiers: [String]) {
        let content = UNMutableNotificationContent()
        content.title = "PigulkaTime"
        let name = editingCell?.textField.text ?? "Time for pill"
        content.body = "Time for \(name) \(selectedDosage ?? "no dosage") \(selectedType ?? "no type")"
        // Добавляем виброотклик
        content.sound = .default
        var notificationIdentifiers = [String]()
        
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
                
                // Добавим принты для отслеживания значений переменных
                print("Index: \(index)")
                print("Selected Dosage: \(selectedDosage ?? "N/A")")
                print("Selected Type: \(selectedType ?? "N/A")")
                
                if let trigger = getNotificationTrigger(forFrequency: frequency, dateComponents: dateComponents) {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let notificationDate = Calendar.current.date(from: dateComponents)
                    
                    if let notificationDate = notificationDate {
                        let formattedDate = dateFormatter.string(from: notificationDate)
                        
                        let requestIdentifier = UUID().uuidString
                        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
                        notificationIdentifiers.append(requestIdentifier)
                        
                        print("Уведомление будет установлено с идентификатором \(requestIdentifier) на дату \(formattedDate) в \(time) с частотой \(frequency)")
                        
                        // Виводимо інформацію про день, час і частоту перед встановленням сповіщення
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
        // Зберегти ідентифікатори у властивості класу
        self.notificationIdentifiers = notificationIdentifiers
        print("Массив индентификатооров: \(notificationIdentifiers)")
    }
    // Видалення нотифікації по ідентифікатору
    func removeNotification(withIdentifier identifier: String) {
        print("Removing notification with identifier: \(identifier)")
        // Видаляємо нотифікацію за її ідентифікатором
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        // Видаляємо ідентифікатор зі списку
        if let index = notificationIdentifiers.firstIndex(of: identifier) {
            notificationIdentifiers.remove(at: index)
        }
    }
    // Очистка всіх нотифікацій
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        // Очищення масиву
        notificationIdentifiers.removeAll()
    }
}
