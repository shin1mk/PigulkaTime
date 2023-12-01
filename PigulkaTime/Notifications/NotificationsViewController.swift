//
//  NotificationsViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit
import SnapKit
import UserNotifications

final class NotificationsViewController: UIViewController, FirstCustomTableCellDelegate, SecondCustomTableCellDelegate {
    private let feedbackGenerator = UISelectionFeedbackGenerator() // виброотклик
    // выбранное время
    var FirstSelectedHour: Int = 0
    var FirstSelectedMinute: Int = 0
    
    var SecondSelectedHour: Int = 0
    var SecondSelectedMinute: Int = 0
    //MARK: Properties
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(FirstCustomTableCell.self, forCellReuseIdentifier: "FirstCustomTableCell")
        tableView.register(SecondCustomTableCell.self, forCellReuseIdentifier: "SecondCustomTableCell")
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
    // load from userDefaults
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
            print("Данные успешно загружены:")
            print("FirstSelectedHour: \(FirstSelectedHour)")
            print("FirstSelectedMinute: \(FirstSelectedMinute)")
        } else {
            print("Данные не найдены в UserDefaults.")
        }
    }
    
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
            print("Данные успешно загружены:")
            print("SecondSelectedHour: \(SecondSelectedHour)")
            print("SecondSelectedMinute: \(SecondSelectedMinute)")
        } else {
            print("Данные не найдены в UserDefaults.")
        }
    }
    // toggle switch
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
} // end
