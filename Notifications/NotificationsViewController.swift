//
//  NotificationsViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit
import SnapKit
import UserNotifications

final class NotificationsViewController: UIViewController, FirstCustomTableCellDelegate {
    private let feedbackGenerator = UISelectionFeedbackGenerator() // виброотклик
    // выбранное время
    var selectedHour: Int = 0
    var selectedMinute: Int = 0
    //MARK: Properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(FirstCustomTableCell.self, forCellReuseIdentifier: "FirstCustomTableCell")
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
} // end
