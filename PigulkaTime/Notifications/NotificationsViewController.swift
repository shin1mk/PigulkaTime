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
    var selectedHour: Int = 0
    var selectedMinute: Int = 0
    var selectedDays: String = ""
    
    let daysArray = ["1 day", "2 days", "3 days", "4 days", "5 days", "6 days", "7 days", "10 days", "14 days", "30 days", "60 days", "90 days"]
    let daysIntervals: [TimeInterval] = [
        1 * 24 * 60 * 60,   // 1 day
        2 * 24 * 60 * 60,   // 2 days
        3 * 24 * 60 * 60,   // 3 days
        4 * 24 * 60 * 60,   // 4 days
        5 * 24 * 60 * 60,   // 5 days
        6 * 24 * 60 * 60,   // 6 days
        7 * 24 * 60 * 60,   // 1 week
        10 * 24 * 60 * 60,  // 10 days
        14 * 24 * 60 * 60,  // 2 weeks
        30 * 24 * 60 * 60,  // 1 month
        60 * 24 * 60 * 60,  // 2 months
        90 * 24 * 60 * 60   // 3 months
    ]
    
    //MARK: Properties
    lazy var tableView: UITableView = {
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
    
    func didToggleSwitch(cell: FirstCustomTableCell, isOn: Bool) {
        print("Switch is \(isOn ? "ON" : "OFF")")
        
        DispatchQueue.main.async {
            if isOn {
                // Свитч в положении "ON", установите текст по умолчанию
                cell.setFirstTimeText("Choose \u{2192}")
                cell.setFirstDaysText("Days left")
            } else {

            }

        }
    }
} // end
