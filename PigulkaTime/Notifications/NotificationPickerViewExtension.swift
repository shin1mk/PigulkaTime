//
//  NotificationPickerViewExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit

extension NotificationsViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // 2 компонента для часов и минут
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            // часов (0-23)
            return 24
        case 1:
            // минут (0-59)
            return 60
        default:
            return 0
        }
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
           return 60 // width based
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            // часы с нулями
            return String(format: "%02d", row)
        case 1:
            // минуты с нулями
            return String(format: "%02d", row)
        default:
            return nil
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          switch component {
          case 0:
              FirstSelectedHour = row
              print("Selected Hour: \(FirstSelectedHour)")
          case 1:
              FirstSelectedMinute = row
              print("Selected Minute: \(FirstSelectedMinute)")
          default:
              break
          }
      }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title: String
        switch component {
        case 0:
            title = (row == 0) ? "" : String(format: "%02d", row)
        case 1:
            title = (row == 0) ? "" : String(format: "%02d", row)
        default:
            return nil
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.SFUITextMedium(ofSize: 20)!
        ]
        return NSAttributedString(string: title, attributes: attributes)
    }
}
