//
//  NotificationsViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit
import SnapKit
import UserNotifications

final class NotificationsViewController: UIViewController, FirstCustomTableCellDelegate, SecondCustomTableCellDelegate, ThirdCustomTableCellDelegate, FourthCustomTableCellDelegate, FifthCustomTableCellDelegate {

    
    private let feedbackGenerator = UISelectionFeedbackGenerator() // виброотклик
    // выбранное время
    var FirstSelectedHour: Int = 0
    var FirstSelectedMinute: Int = 0
    
    var SecondSelectedHour: Int = 0
    var SecondSelectedMinute: Int = 0
    
    var ThirdSelectedHour: Int = 0
    var ThirdSelectedMinute: Int = 0
    
    var FourthSelectedHour: Int = 0
    var FourthSelectedMinute: Int = 0
    
    var FifthSelectedHour: Int = 0
    var FifthSelectedMinute: Int = 0
    
    //MARK: Properties
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(FirstCustomTableCell.self, forCellReuseIdentifier: "FirstCustomTableCell")
        tableView.register(SecondCustomTableCell.self, forCellReuseIdentifier: "SecondCustomTableCell")
        tableView.register(ThirdCustomTableCell.self, forCellReuseIdentifier: "ThirdCustomTableCell")
        tableView.register(FourthCustomTableCell.self, forCellReuseIdentifier: "FourthCustomTableCell")
        tableView.register(FifthCustomTableCell.self, forCellReuseIdentifier: "FifthCustomTableCell")
        return tableView
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Notifications"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextHeavy(ofSize: 30)
        return titleLabel
    }()
    private let subtractImageView = UIImageView(image: UIImage(named: "subtract")) // line
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadFirstDataFromUserDefaultsAndUpdateCell()
        loadSecondDataFromUserDefaultsAndUpdateCell()
        loadThirdDataFromUserDefaultsAndUpdateCell()
        loadFourthDataFromUserDefaultsAndUpdateCell()
        loadFifthDataFromUserDefaultsAndUpdateCell()
    }
    //MARK: Constraints
    private func setupConstraints() {
        view.backgroundColor = .black
        // substract
        view.addSubview(subtractImageView)
        subtractImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(10)
        }
        // titleLabel
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        // tableView
        view.addSubview(tableView)  // Добавьте эту строку
        tableView.backgroundColor = .clear
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
        }
    }
    // setup table view
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    // load from userDefaults1
    private func loadFirstDataFromUserDefaultsAndUpdateCell() {
        let defaults = UserDefaults.standard
        if let hour = defaults.value(forKey: "FirstSelectedHour") as? Int,
           let minute = defaults.value(forKey: "FirstSelectedMinute") as? Int {
            // Преобразование значения days в String
            FirstSelectedHour = hour
            FirstSelectedMinute = minute
            tableView.reloadData() // Обновите всю таблицу
            // Обновление соответствующей ячейки таблицы
            let indexPath = IndexPath(row: 0, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? FirstCustomTableCell {
                // Обновляем текст в ячейке с выбранным временем
                cell.setFirstTimeText(String(format: "%02d:%02d", FirstSelectedHour, FirstSelectedMinute))
            } else {
                print("Ячейка не найдена")
            }
            // Вывод в консоль для отслеживания
            print("1 Данные успешно загружены:")
            print("FirstSelectedHour: \(FirstSelectedHour)")
            print("FirstSelectedMinute: \(FirstSelectedMinute)")
        } else {
            print("1 Данные не найдены в UserDefaults.")
        }
    }
    // load from userDefaults2
    private func loadSecondDataFromUserDefaultsAndUpdateCell() {
        let defaults = UserDefaults.standard
        if let hour = defaults.value(forKey: "SecondSelectedHour") as? Int,
           let minute = defaults.value(forKey: "SecondSelectedMinute") as? Int {
            // Преобразование значения days в String
            SecondSelectedHour = hour
            SecondSelectedMinute = minute
            tableView.reloadData() // Обновите всю таблицу
            // Обновление соответствующей ячейки таблицы
            let indexPath = IndexPath(row: 1, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? SecondCustomTableCell {
                // Обновляем текст в ячейке с выбранным временем
                cell.setSecondTimeText(String(format: "%02d:%02d", SecondSelectedHour, SecondSelectedMinute))
            } else {
                print("Ячейка не найдена")
            }
            // Вывод в консоль для отслеживания
            print("2 Данные успешно загружены:")
            print("SecondSelectedHour: \(SecondSelectedHour)")
            print("SecondSelectedMinute: \(SecondSelectedMinute)")
        } else {
            print("2 Данные не найдены в UserDefaults.")
        }
    }
    // load from userDefaults3
    private func loadThirdDataFromUserDefaultsAndUpdateCell() {
        let defaults = UserDefaults.standard
        if let hour = defaults.value(forKey: "ThirdSelectedHour") as? Int,
           let minute = defaults.value(forKey: "ThirdSelectedMinute") as? Int {
            // Преобразование значения days в String
            ThirdSelectedHour = hour
            ThirdSelectedMinute = minute
            tableView.reloadData() // Обновите всю таблицу
            // Обновление соответствующей ячейки таблицы
            let indexPath = IndexPath(row: 2, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? ThirdCustomTableCell {
                // Обновляем текст в ячейке с выбранным временем
                cell.setThirdTimeText(String(format: "%02d:%02d", ThirdSelectedHour, ThirdSelectedMinute))
            } else {
                print("Ячейка не найдена")
            }
            // Вывод в консоль для отслеживания
            print("3 Данные успешно загружены:")
            print("ThirdSelectedHour: \(ThirdSelectedHour)")
            print("ThirdSelectedMinute: \(ThirdSelectedMinute)")
        } else {
            print("3 Данные не найдены в UserDefaults.")
        }
    }
    // load from userDefaults4
    private func loadFourthDataFromUserDefaultsAndUpdateCell() {
        let defaults = UserDefaults.standard
        if let hour = defaults.value(forKey: "FourthSelectedHour") as? Int,
           let minute = defaults.value(forKey: "FourthSelectedMinute") as? Int {
            // Преобразование значения days в String
            FourthSelectedHour = hour
            FourthSelectedMinute = minute
            tableView.reloadData() // Обновите всю таблицу
            // Обновление соответствующей ячейки таблицы
            let indexPath = IndexPath(row: 3, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? FourthCustomTableCell {
                // Обновляем текст в ячейке с выбранным временем
                cell.setFourthTimeText(String(format: "%02d:%02d", FourthSelectedHour, FourthSelectedMinute))
            } else {
                print("Ячейка не найдена")
            }
            // Вывод в консоль для отслеживания
            print("4 Данные успешно загружены:")
            print("FourthSelectedHour: \(FourthSelectedHour)")
            print("FourthSelectedMinute: \(FourthSelectedMinute)")
        } else {
            print("4 Данные не найдены в UserDefaults.")
        }
    }
    // load from userDefaults5
    private func loadFifthDataFromUserDefaultsAndUpdateCell() {
        let defaults = UserDefaults.standard
        if let hour = defaults.value(forKey: "FifthSelectedHour") as? Int,
           let minute = defaults.value(forKey: "FifthSelectedMinute") as? Int {
            // Преобразование значения days в String
            FifthSelectedHour = hour
            FifthSelectedMinute = minute
            tableView.reloadData() // Обновите всю таблицу
            // Обновление соответствующей ячейки таблицы
            let indexPath = IndexPath(row: 4, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? FifthCustomTableCell {
                // Обновляем текст в ячейке с выбранным временем
                cell.setFifthTimeText(String(format: "%02d:%02d", FifthSelectedHour, FifthSelectedMinute))
            } else {
                print("Ячейка не найдена")
            }
            // Вывод в консоль для отслеживания
            print("5 Данные успешно загружены:")
            print("FifthSelectedHour: \(FifthSelectedHour)")
            print("FifthSelectedMinute: \(FifthSelectedMinute)")
        } else {
            print("5 Данные не найдены в UserDefaults.")
        }
    }
    // toggle switch1
    func didFirstToggleSwitch(cell: FirstCustomTableCell, isOn: Bool) {
        print("First Switch is \(isOn ? "ON" : "OFF")")
        
        DispatchQueue.main.async {
            if isOn {
                self.createFirstNotification()
            } else {
                self.cancelFirstNotification()
            }
        }
    }
    // toggle switch2
    func didSecondToggleSwitch(cell: SecondCustomTableCell, isOn: Bool) {
        print("Second Switch is \(isOn ? "ON" : "OFF")")
        
        DispatchQueue.main.async {
            if isOn {
                self.createSecondNotification()
            } else {
                self.cancelSecondNotification()
            }
        }
    }
    // toggle switch3
    func didThirdToggleSwitch(cell: ThirdCustomTableCell, isOn: Bool) {
        print("Third Switch is \(isOn ? "ON" : "OFF")")
        
        DispatchQueue.main.async {
            if isOn {
                self.createThirdNotification()
            } else {
                self.cancelThirdNotification()
            }
        }
    }
    // toggle switch4
    func didFourthToggleSwitch(cell: FourthCustomTableCell, isOn: Bool) {
        print("Third Switch is \(isOn ? "ON" : "OFF")")
        
        DispatchQueue.main.async {
            if isOn {
                self.createFourthNotification()
            } else {
                self.cancelFourthNotification()
            }
        }
    }
    // toggle switch5
    func didFifthToggleSwitch(cell: FifthCustomTableCell, isOn: Bool) {
        print("Fifth Switch is \(isOn ? "ON" : "OFF")")
        
        DispatchQueue.main.async {
            if isOn {
                self.createFifthNotification()
            } else {
                self.cancelFifthNotification()
            }
        }
    }
} // end
