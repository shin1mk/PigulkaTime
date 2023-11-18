//
//  TimePickerExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 14.11.2023.
//

import UIKit
import UserNotifications

extension PillsViewController: TimeCustomTableCellDelegate {
    // MARK: - Time Picker
    func didSelectTime(cell: TimeCustomTableCell) {
        let pickerViewController = createPickerViewController()
        present(pickerViewController, animated: true, completion: nil)
    }
    
    private func createPickerViewController() -> UIViewController {
        let pickerViewController = UIViewController()
        let pickerView = createPickerView(for: pickerViewController)
        let okButton = createTimeOkButton(for: pickerViewController)
        
        pickerViewController.view.addSubview(pickerView)
        pickerViewController.view.addSubview(okButton)
        pickerViewController.modalPresentationStyle = .overCurrentContext
        
        return pickerViewController
    }
    
    private func createPickerView(for pickerViewController: UIViewController) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 6 // For Type picker view
        pickerView.backgroundColor = .black
        pickerView.selectRow(0, inComponent: 0, animated: false)
        
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        
        return pickerView
    }
    
    private func createTimeOkButton(for pickerViewController: UIViewController) -> UIButton {
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(timeOkButtonTapped(_:)), for: .touchUpInside)
        
        let bottomMargin: CGFloat = 30
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        
        return okButton
    }
    
    @objc private func timeOkButtonTapped(_ sender: UIButton) {
        // Получите выбранное время из свойства selectedStarting
        guard let selectedTime = selectedTime else {
            print("No time selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        // в консоль выбранное время
        print("Selected time at: \(selectedTime)")
        // Установите календарь и текущую дату
        let calendar = Calendar.current
        let currentDate = Date()
        // Разделите строку времени
        let timeComponents = selectedTime.components(separatedBy: ":")
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
            //            let nextDaySelectedDate = calendar.date(from: nextDayDateComponents)
            // Запланируйте уведомление
            //            scheduleNotification(at: nextDaySelectedDate ?? Date())
            // выбранное время в typeLabel
            if let timeCell = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? TimeCustomTableCell {
                timeCell.setTimeLabelText("\(selectedTime)")
            }
            // Снимите фокус с текстового поля
            editingCell?.textField.resignFirstResponder()
            // Закройте UIViewController при нажатии кнопки "OK"
            dismiss(animated: true, completion: nil)
            return
        }
        // Запланируйте уведомление
        //        scheduleNotification(at: selectedDate ?? Date())
        // выбранное время в typeLabel
        if let timeCell = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? TimeCustomTableCell {
            timeCell.setTimeLabelText("\(selectedTime)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
}
