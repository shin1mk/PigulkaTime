////
////  NotificationPickerViewExtension.swift
////  PigulkaTime
////
////  Created by SHIN MIKHAIL on 23.11.2023.
////
//
//import UIKit
//
//extension NotificationsViewController {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 3 // 1 компонент для дней, 2 компонента для часов и минут
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        switch component {
//        case 0:
//            // Количество строк для дней
//            return 180 // Например, 10 дней
//        case 1:
//            // Количество строк для часов (0-23)
//            return 24
//        case 2:
//            // Количество строк для минут (0-59)
//            return 60
//        default:
//            return 0
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        switch component {
//        case 0:
//            // Возвращайте строку для каждого дня
//            return "\(row + 1)"
//        case 1:
//            // Возвращаем часы с ведущими нулями
//            return String(format: "%02d", row)
//        case 2:
//            // Возвращаем минуты с ведущими нулями
//            return String(format: "%02d", row)
//        default:
//            return nil
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        switch component {
//        case 0:
//            // Обработайте выбор дня
//            let selectedDay = row + 1
//            print("Selected Day: \(selectedDay)")
//        case 1:
//            selectedHour = row
//            print("Selected Hour: \(selectedHour)")
//        case 2:
//            selectedMinute = row
//            print("Selected Minute: \(selectedMinute)")
//        default:
//            break
//        }
//    }
//
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let title: String
//        switch component {
//        case 0:
//            title = "\(row + 1)"
//        case 1, 2:
//            title = String(format: "%02d", row)
//        default:
//            return nil
//        }
//
//        let attributes: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor.white,
//            .font: UIFont.SFUITextMedium(ofSize: 16)! // Настройте шрифт по вашему усмотрению
//        ]
//        return NSAttributedString(string: title, attributes: attributes)
//    }
//}

import UIKit

extension NotificationsViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3 // 1 компонент для дней, 2 компонента для часов и минут
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            // Количество строк для дней
            return daysArray.count
        case 1:
            // Количество строк для часов (0-23)
            return 24
        case 2:
            // Количество строк для минут (0-59)
            return 60
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            // Возвращайте строку для каждого дня
            return daysArray[row]
        case 1:
            // Возвращаем часы с ведущими нулями
            return String(format: "%02d", row)
        case 2:
            // Возвращаем минуты с ведущими нулями
            return String(format: "%02d", row)
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          switch component {
          case 0:
              // Обработайте выбор дня
              let selectedDayInterval = daysIntervals[row]
              print("Selected Day Interval: \(selectedDayInterval)")
              // Обновляем значение selectedDays in vc
              selectedDays = daysArray[row]
          case 1:
              selectedHour = row
              print("Selected Hour: \(selectedHour)")
          case 2:
              selectedMinute = row
              print("Selected Minute: \(selectedMinute)")
          default:
              break
          }
      }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title: String
        switch component {
        case 0:
            title = daysArray[row]
        case 1, 2:
            title = String(format: "%02d", row)
        default:
            return nil
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.SFUITextMedium(ofSize: 16)! // Настройте шрифт по вашему усмотрению
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
}
