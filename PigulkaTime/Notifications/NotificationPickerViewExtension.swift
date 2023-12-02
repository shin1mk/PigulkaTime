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
        switch pickerView.tag {
        case 0:
            // Обработка для первого пикера
            switch component {
            case 0:
                FirstSelectedHour = row
                print("Selected Hour for First Picker: \(FirstSelectedHour)")
            case 1:
                FirstSelectedMinute = row
                print("Selected Minute for First Picker: \(FirstSelectedMinute)")
            default:
                break
            }
        case 1:
            // Обработка для второго пикера
            switch component {
            case 0:
                SecondSelectedHour = row
                print("Selected Hour for Second Picker: \(SecondSelectedHour)")
            case 1:
                SecondSelectedMinute = row
                print("Selected Minute for Second Picker: \(SecondSelectedMinute)")
            default:
                break
            }
        case 2:
            // Обработка для второго пикера
            switch component {
            case 0:
                ThirdSelectedHour = row
                print("Selected Hour for Second Picker: \(ThirdSelectedHour)")
            case 1:
                ThirdSelectedMinute = row
                print("Selected Minute for Second Picker: \(ThirdSelectedMinute)")
            default:
                break
            }
        default:
            break
        }
    }
}
