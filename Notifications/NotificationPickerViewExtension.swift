//
//  NotificationPickerViewExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit

extension NotificationsViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            // Количество строк для часов (0-23)
            return 24
        } else {
            // Количество строк для минут (0-59)
            return 60
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            // Возвращаем часы с ведущими нулями
            return String(format: "%02d", row)
        } else {
            // Возвращаем минуты с ведущими нулями
            return String(format: "%02d", row)
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedHour = row
            print("Selected Hour: \(selectedHour)")
        } else {
            selectedMinute = row
            print("Selected Minute: \(selectedMinute)")
        }
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title: String
        if component == 0 {
            title = String(format: "%02d", row)
        } else {
            title = String(format: "%02d", row)
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.SFUITextMedium(ofSize: 16)! // Настройте шрифт по вашему усмотрению
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
}
