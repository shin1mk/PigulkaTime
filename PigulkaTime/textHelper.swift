//
//  textHelper.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 07.11.2023.
//

/*
 
 если выбрано каждые 1 час то надо выбрать сколько раз и время
 
 Частота: Если каждый час то выводим уведомление начиная с какого то времени
 И убираем графу сколько раз в день

 Daily : Если два раза в день, то дать выбор времени уведомления

 На мейн контроллере если выпил таблетку, то как то отметить что выпил
 
 
 
 //MARK: Notifications

 @objc private func startingOkButtonTapped(_ sender: UIButton) {
     // Получите выбранное время из свойства selectedStarting
     guard let selectedStarting = selectedStarting else {
         print("No time selected.")
         dismiss(animated: true, completion: nil)
         return
     }
     
     // Выведите в консоль выбранное время
     print("Selected starting at: \(selectedStarting)")

     // Установите календарь и текущую дату
     let calendar = Calendar.current
     let currentDate = Date()
     
     // Разделите строку времени
     let timeComponents = selectedStarting.components(separatedBy: ":")
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
         print("Selected time is in the past.")
         dismiss(animated: true, completion: nil)
         return
     }
     
     // Запланируйте уведомление
     scheduleNotification(at: selectedDate ?? Date())

     // выбранное время в typeLabel
     if let typeCell = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? StartingCustomTableCell {
         typeCell.setStartingText("\(selectedStarting)")
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
     
     let name = editingCell?.textField.text ?? "Пора принять лекарство"
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
     // cancel notification
     private func cancelNotification() {
         let identifier = "TimerNotification"
         UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
         print("Уведомление с идентификатором '\(identifier)' было отменено.")
     }
 }

 
 first dose => frequency => how many days
 frequency => first dose =>
 */
