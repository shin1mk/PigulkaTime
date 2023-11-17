//
//  PillsViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 10.11.2023.
//

import UIKit
import SnapKit
import UserNotifications

// протокол для передачи информации на MainViewController
protocol PillsViewControllerDelegate: AnyObject {
    func pillsViewController(_ controller: PillsViewController, didSavePills pills: [Pill])
}
protocol TypeCustomTableCellDelegate: AnyObject {
    func didSelectType(cell: TypeCustomTableCell)
}
protocol DosageCustomTableCellDelegate: AnyObject {
    func didSelectDosage(cell: DosageCustomTableCell)
}
protocol FrequencyCustomTableCellDelegate: AnyObject {
    func didSelectFrequency(cell: FrequencyCustomTableCell)
}
protocol DaysCustomTableCellDelegate: AnyObject {
    func didSelectDays(cell: DaysCustomTableCell)
}
protocol TimesCustomTableCellDelegate: AnyObject {
    func didSelectTimes(cell: TimesCustomTableCell)
}
protocol FirstDoseCustomTableCellDelegate: AnyObject {
    func didSelectFirst(cell: FirstDoseCustomTableCell)
}


final class PillsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    weak var delegate: PillsViewControllerDelegate?
    
    //MARK: Public
    public var editingCell: DrugNameCustomTableCell? // изменения ячейки
    public var pillsArray: [Pill] = [] // массив
    // for type picker view
    public let types = ["", "Pills", "Injections", "Suppositories", "Tablets", "Capsules", "Syrups", "Drops", "Ointments", "Sprays", "Lozenges", "Inhalers"]
    public var selectedType: String?
    // for dosage picker view
    public let dosages = ["", "0.25", "0.5", "1", "1.5", "2", "2.5", "3", "4", "5", "10", "15", "20", "25", "30"]
    public var selectedDosage: String?
    // for frequency picker view
    public let frequency = ["", "Daily", "Every Hour", "Every 2 hours", "Every 3 hours", "Every 4 hours", "Every 6 hours", "Every 8 hours", "Every 12 hours", "Every 2 days", "Every 3 days", "Every 4 days", "Every 5 days", "Every 6 days", "Weekly", "Every 2 weeks", "Every 3 weeks", "Every 4 weeks"]
    public var selectedFrequency: String?
    // for days picker view
    //    public let days: [String] = (0...100).map {  "\($0) day\($0 == 1 ? "" : "s")" }
    public let days: [String] = (0...100).compactMap { $0 == 1 ? nil : "\($0) day\($0 == 1 ? "" : "s")" }
    public var selectedDays: String?
    // for times per day picker view
    public let times: [String] = (0...7).map { "\($0)" }
    public var selectedTimes: String?
    // for starting picker view
  
    //    public let firstDose: [String] = {
    //        var times = [String]()
    //        for hour in 0...23 {
    //            for minute in stride(from: 0, through: 55, by: 5) {
    //                times.append(String(format: "%02d:%02d", hour, minute))
    //            }
    //        }
    //        return times
    //    }()
    //    public var selectedFirstDose: String?
        public let firstDose: [Date] = {
            var dates = [Date]()
            let currentDate = Date()

            for hour in 0...23 {
                for minute in stride(from: 0, through: 55, by: 5) {
                    var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: currentDate)
                    components.hour = hour
                    components.minute = minute
                    if let date = Calendar.current.date(from: components) {
                        dates.append(date)
                    }
                }
            }
            return dates
        }()
        var selectedFirstDose: Date?



    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DrugNameCustomTableCell.self, forCellReuseIdentifier: "DrugNameCustomCell")
        tableView.register(TypeCustomTableCell.self, forCellReuseIdentifier: "TypeCustomCell")
        tableView.register(DosageCustomTableCell.self, forCellReuseIdentifier: "DosageCustomCell")
        tableView.register(FrequencyCustomTableCell.self, forCellReuseIdentifier: "FrequencyCustomCell")
        tableView.register(DaysCustomTableCell.self, forCellReuseIdentifier: "DaysCustomCell")
        tableView.register(TimesCustomTableCell.self, forCellReuseIdentifier: "TimesCustomCell")
        tableView.register(FirstDoseCustomTableCell.self, forCellReuseIdentifier: "FirstDoseCustomCell")
        return tableView
    }()
    //MARK: Properties
    private let bottomMarginGuide = UILayoutGuide() // нижняя граница
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Add pill"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextHeavy(ofSize: 30)
        return titleLabel
    }()
    private let saveButton: UIButton = {
        let saveButton = UIButton()
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 20)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .systemGray6
        saveButton.layer.cornerRadius = 5
        return saveButton
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
        setupTarget()
        setupGesture()
    }
    //MARK: Constraints
    private func setupConstraints() {
        view.backgroundColor = .black
        // titleLabel
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        // bottomMarginGuide граница что б за нее не заходила таблица
        view.addLayoutGuide(bottomMarginGuide)
        bottomMarginGuide.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
        }
        // tableView
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.clear
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(bottomMarginGuide.snp.top)
        }
        // saveButton
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(45)
        }
    }
    // Delegate/DataSource
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    // targets
    private func setupTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    // saveButton
    @objc private func saveButtonTapped() {
         // Проверяем, что у нас есть ссылка на редактируемую ячейку
         guard let editingCell = editingCell else {
             // В случае, если editingCell равен nil (нет редактируемой ячейки), выходим из метода
             return
         }

         var newPill: Pill? // Declare newPill here

         if let firstDoseDate = firstDose.first {
             newPill = Pill(
                 name: editingCell.textField.text ?? "",
                 dosage: selectedDosage ?? "",
                 type: selectedType ?? "",
                 frequency: selectedFrequency ?? "",
                 days: (selectedDays ?? "") + " left",
                 times: (selectedTimes ?? "") + " times",
                 isEditable: true,
                 firstDose: firstDoseDate
             )
             // Используйте newPill
         } else {
             print("Ошибка: Массив firstDose пуст!")
         }

         if let newPill = newPill {
             print("Содержимое newPill:", newPill)
             // Добавляем новый объект Pill в массив pillsArray
             pillsArray.append(newPill)
             
             // Вызываем делегата для передачи обновленного массива
             delegate?.pillsViewController(self, didSavePills: pillsArray)
             // Выводим в консоль время уведомления
             scheduleNotification(for: newPill)
         }

         // Закрываем текущий контроллер
         dismiss(animated: true, completion: nil)
     }

     
    
} //end
//MARK: tap to close Keyboard
extension PillsViewController: UIGestureRecognizerDelegate {
    private func setupGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGestureRecognizer.cancelsTouchesInView = false
        tapGestureRecognizer.delegate = self
        tableView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            view.endEditing(true)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
//MARK: Notifications
extension PillsViewController {
    //    private func createNotification(for pill: Pill) {
    //        // Извлекаем дату и время из строки "Next: HH:mm" в формате DateFormatter
    //        let content = UNMutableNotificationContent()
    //        content.title = "Принять лекарство"
    //        content.body = "Пора"
    //
    //        // Создаем триггер для уведомления через 5 секунд (пример)
    //        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
    //
    //        // Создаем запрос на уведомление
    //        let request = UNNotificationRequest(identifier: "pillNotification", content: content, trigger: trigger)
    //
    //        // Регистрируем запрос на уведомление
    //        UNUserNotificationCenter.current().add(request) { (error) in
    //            if let error = error {
    //                print("Ошибка при создании уведомления: \(error)")
    //            } else {
    //                print("Уведомление успешно создано")
    //            }
    //        }
    //    }
    
    private func scheduleNotification(for pill: Pill) {
            // Ensure that firstDose is not nil
            if let firstDoseDate = pill.firstDose {
                // Создаем контент уведомления
                let content = UNMutableNotificationContent()
                content.title = "Принять лекарство"
                content.body = "Пора принять \(pill.name ?? "Лекарство")"

                // Создаем компоненты даты для первой дозы
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: firstDoseDate)

                // Создаем триггер для уведомления
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

                // Создаем запрос на уведомление
                let request = UNNotificationRequest(identifier: "pillNotification", content: content, trigger: trigger)

                // Регистрируем запрос на уведомление
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Ошибка при создании уведомления: \(error)")
                    } else {
                        print("Уведомление успешно создано")
                    }
                }
            } else {
                print("Ошибка: Невозможно получить дату первой дозы")
            }
        }


    
}

