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
            //            return 60
            return 60 / 5
            
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
            //            return String(format: "%02d", row)
            return String(format: "%02d", row * 5)
            
        default:
            return nil
        }
    }
    
    //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //        switch pickerView.tag {
    //        case 0:
    //            // Обработка для первого пикера
    //            switch component {
    //            case 0:
    //                FirstSelectedHour = row
    //                print("Selected Hour for First Picker: \(FirstSelectedHour)")
    //            case 1:
    //                FirstSelectedMinute = row
    //                print("Selected Minute for First Picker: \(FirstSelectedMinute)")
    //            default:
    //                break
    //            }
    //        case 1:
    //            // Обработка для второго пикера
    //            switch component {
    //            case 0:
    //                SecondSelectedHour = row
    //                print("Selected Hour for Second Picker: \(SecondSelectedHour)")
    //            case 1:
    //                SecondSelectedMinute = row
    //                print("Selected Minute for Second Picker: \(SecondSelectedMinute)")
    //            default:
    //                break
    //            }
    //        case 2:
    //            // Обработка для второго пикера
    //            switch component {
    //            case 0:
    //                ThirdSelectedHour = row
    //                print("Selected Hour for Second Picker: \(ThirdSelectedHour)")
    //            case 1:
    //                ThirdSelectedMinute = row
    //                print("Selected Minute for Second Picker: \(ThirdSelectedMinute)")
    //            default:
    //                break
    //            }
    //        default:
    //            break
    //        }
    //    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let step = 5 // шаг в минутах
        
        switch pickerView.tag {
        case 0:
            // Обработка для первого пикера
            switch component {
            case 0:
                FirstSelectedHour = row
                print("Selected Hour for First Picker: \(FirstSelectedHour)")
            case 1:
                FirstSelectedMinute = row * step
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
                SecondSelectedMinute = row * step
                print("Selected Minute for Second Picker: \(SecondSelectedMinute)")
            default:
                break
            }
        case 2:
            // Обработка для третьего пикера
            switch component {
            case 0:
                ThirdSelectedHour = row
                print("Selected Hour for Third Picker: \(ThirdSelectedHour)")
            case 1:
                ThirdSelectedMinute = row * step
                print("Selected Minute for Third Picker: \(ThirdSelectedMinute)")
            default:
                break
            }
        case 3:
            // Обработка для третьего пикера
            switch component {
            case 0:
                FourthSelectedHour = row
                print("Selected Hour for Fourth Picker: \(FourthSelectedHour)")
            case 1:
                FourthSelectedMinute = row * step
                print("Selected Minute for Fourth Picker: \(FourthSelectedMinute)")
            default:
                break
            }
        case 4:
            // Обработка для третьего пикера
            switch component {
            case 0:
                FifthSelectedHour = row
                print("Selected Hour for Fifth Picker: \(FifthSelectedHour)")
            case 1:
                FifthSelectedMinute = row * step
                print("Selected Minute for Fifth Picker: \(FifthSelectedMinute)")
            default:
                break
            }
        default:
            break
        }
    }
}
