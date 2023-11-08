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
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    private let bottomMarginGuide = UILayoutGuide()

    private var pillsArray: [Pill] = []
    //MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        return tableView
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        let pillImage = UIImage(systemName: "pill")
        let titleLabelText = "Pills "
        // сначала текст, а потом изображение
        let attributedText = NSMutableAttributedString(string: titleLabelText)
        attributedText.append(NSAttributedString(attachment: NSTextAttachment(image: pillImage!)))
        titleLabel.attributedText = attributedText
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextHeavy(ofSize: 35)
        titleLabel.textColor = .white // Изменили цвет шрифта на белый
        return titleLabel
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        // plus.fill icon attachment
        let plusFillImage = UIImage(systemName: "plus.circle.fill")?.withTintColor(.white)
        let plusFillAttachment = NSTextAttachment(image: plusFillImage!)
                let pillImage = UIImage(systemName: "pill")?.withTintColor(.white)
        // attributed text
        let attributedText = NSMutableAttributedString(string: " Add pills ")
        attributedText.insert(NSAttributedString(attachment: plusFillAttachment), at: 0)
        attributedText.append(NSAttributedString(attachment: NSTextAttachment(image: pillImage!)))
        // text color to white
        attributedText.addAttributes([.font: UIFont.SFUITextRegular(ofSize: 20)!, .foregroundColor: UIColor.white], range: NSRange(location: 1, length: "Add Pills ".count))
        button.setAttributedTitle(attributedText, for: .normal)
        return button
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
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
        // bottomMarginGuide
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
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    // targets
    private func setupTarget() {
        addButton.addTarget(self, action: #selector(addPillButtonTapped), for: .touchUpInside)
    }
    // func
    @objc private func addPillButtonTapped() {
        print("add pill button")
        feedbackGenerator.selectionChanged() // Добавьте виброотклик
        // Создание объекта таблетки (предположим, у вас есть модель Pill)
        let newPill = Pill(name: "", dosage: "")
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
