//
//  SettingPickerExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 14.11.2023.
//

import UIKit
//MARK: Settings Picker view
extension PillsViewController {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            selectedType = types[row]
            print("Selected Type: \(selectedType ?? "No type selected")")
        case 2:
            selectedDosage = dosages[row]
            print("Selected Dosage: \(selectedDosage ?? "No dosage selected")")
        case 3:
            selectedFrequency = frequency[row]
            print("Selected Frequency: \(selectedFrequency ?? "No frequency selected")")
        case 4:
            selectedDays = days[row]
            print("Selected Days: \(selectedDays ?? "No days selected")")
        case 5:
            selectedTimes = times[row]
            print("Selected Days: \(selectedTimes ?? "No times selected")")
        case 6:
            if component == 0 {
                   // Выбран час
                   let selectedHour = row
//                   let selectedMinute = pickerView.selectedRow(inComponent: 1) * 5
                   let selectedMinute = pickerView.selectedRow(inComponent: 1)
                   selectedStart = String(format: "%02d:%02d", selectedHour, selectedMinute)
               } else {
                   // Выбраны минуты
                   let selectedHour = pickerView.selectedRow(inComponent: 0)
//                   let selectedMinute = row * 5
                   let selectedMinute = row
                   selectedStart = String(format: "%02d:%02d", selectedHour, selectedMinute)
               }
               print("Selected Starting at: \(selectedStart ?? "No starting at selected")")
        default:
            break
        }
    }
    // Методы для UIPickerViewDelegate и UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        case 5:
            return 1
        case 6:
            return 2
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return types.count
        case 2:
            return dosages.count
        case 3:
            return frequency.count
        case 4:
            return days.count
        case 5:
            return times.count
        case 6:
            if component == 0 {
                return 24 // Часы от 0 до 23
            } else {
//                return 12 // Минуты от 0 до 55 с шагом 5
                return 60 // Минуты от 0 до 55 с шагом 5
            }
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return types[row]
        case 2:
            return dosages[row]
        case 3:
            return frequency[row]
        case 4:
            return days[row]
        case 5:
            return times[row]
        case 6:
            if component == 0 {
                return String(format: "%02d", row) // Форматирование часов
            } else {
                return String(format: "%02d", row) // Форматирование минут с шагом 5
//                return String(format: "%02d", row * 5) // Форматирование минут с шагом 5
            }
        default:
            return nil
        }
    }
}
