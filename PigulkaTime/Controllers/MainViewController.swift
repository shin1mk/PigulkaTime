//
//  ViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 07.11.2023.
//

import UIKit
import SnapKit
import UserNotifications

struct Pill {
    var name: String
    var dosage: String
}

final class MainViewController: UIViewController {
    private var pillsArray: [Pill] = []
    private let bottomMarginGuide = UILayoutGuide()
    //MARK: Properties
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        let pillImage = UIImage(systemName: "pill")
        let titleLabelText = "Your pills "
        // сначала текст, а затем изображение
        let attributedText = NSMutableAttributedString(string: titleLabelText)
        attributedText.append(NSAttributedString(attachment: NSTextAttachment(image: pillImage!)))
        titleLabel.attributedText = attributedText
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextHeavy(ofSize: 35)
        return titleLabel
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        return tableView
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        let pillImage = UIImage(systemName: "pill")
        let buttonLabelText = "Add Pills "
        // сначала текст, а затем изображение
        let attributedText = NSMutableAttributedString(string: buttonLabelText)
        attributedText.append(NSAttributedString(attachment: NSTextAttachment(image: pillImage!)))
        // задаем шрифт
        attributedText.addAttributes([.font: UIFont.SFUITextRegular(ofSize: 20)!], range: NSRange(location: 0, length: buttonLabelText.count))
        button.setAttributedTitle(attributedText, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        return button
    }()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupConstraints()
        setupTarget()
    }
    //MARK: Constraints
    private func setupConstraints() {
        view.backgroundColor = .systemOrange
        // titleLabel
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
        }
        // Создайте и добавьте bottomMarginGuide
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
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(bottomMarginGuide.snp.top)
        }
        // addButton
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(45)
        }
    }

    // Delegate/DataSource
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func setupTarget() {
        addButton.addTarget(self, action: #selector(addPillButtonTapped), for: .touchUpInside)
    }
    @objc func addPillButtonTapped() {
        print("add pill button")
        // Создание объекта таблетки (предположим, у вас есть модель Pill)
        let newPill = Pill(name: "Название таблетки", dosage: "Дозировка")
        // Добавление таблетки в источник данных вашей таблицы
        pillsArray.append(newPill)
        // Обновление таблицы
        tableView.reloadData()
    }
} // end
//MARK: TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    //MARK: numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pillsArray.count
    }
    //MARK: cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        // Настройте ячейку с данными из вашего массива pillsArray
        let pill = pillsArray[indexPath.row]
        cell.textLabel?.text = pill.name
        cell.detailTextLabel?.text = pill.dosage

        return cell
    }
    //MARK: didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
