//
//  ViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 07.11.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    public var pillsArray: [Pill] = [] // массив таблеток
    private let feedbackGenerator = UISelectionFeedbackGenerator() // виброотклик
    private let bottomMarginGuide = UILayoutGuide() // нижняя граница
    //MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(MainViewCustomTableCell.self, forCellReuseIdentifier: "MainCustomCell")
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
        titleLabel.font = UIFont.SFUITextBold(ofSize: 40)
        titleLabel.textColor = .white
        return titleLabel
    }()
    private let addButton: UIButton = {
        let button = UIButton()
        // plus.fill icon attachment
        let plusFillImage = UIImage(systemName: "plus.circle.fill")?.withTintColor(.white)
        let plusFillAttachment = NSTextAttachment(image: plusFillImage!)
        // attributed text
        let attributedText = NSMutableAttributedString(string: " Add pills")
        attributedText.insert(NSAttributedString(attachment: plusFillAttachment), at: 0)
        // text color to white
        attributedText.addAttributes([.font: UIFont.SFUITextMedium(ofSize: 20)!, .foregroundColor: UIColor.white], range: NSRange(location: 1, length: "Add Pills".count))
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
        view.backgroundColor = .black
        // titleLabel
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
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
        tableView.backgroundColor = .clear
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
    // add pill кнопка
    @objc private func addPillButtonTapped() {
        feedbackGenerator.selectionChanged()
        // открываем модальное окно
        let pillsViewController = PillsViewController()
        pillsViewController.modalPresentationStyle = .popover
        pillsViewController.delegate = self
        present(pillsViewController, animated: true, completion: nil)
    }
} // end
//MARK: TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    // высота
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    // кол-во строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pillsArray.count
    }
    //содержимое ячечки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCustomCell", for: indexPath) as! MainViewCustomTableCell
        // фон ячейки
        let backgroundCellColor = UIView()
        backgroundCellColor.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundCellColor
        // установим title в ячейку
        let pill = pillsArray[indexPath.row]
        cell.setTitleLabelText(pill.name!)
        cell.setTypeLabelText(pill.type)
        cell.setDosageLabelText(pill.dosage)
        cell.setFrequencyLabelText(pill.frequency)

        return cell
    }
    // нажатая ячейка
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
}
//MARK: открытая функция добавляет в массив данные из PillsViewControler и показывает на экране
extension MainViewController: PillsViewControllerDelegate {
    func pillsViewController(_ controller: PillsViewController, didSavePills pills: [Pill]) {
        pillsArray.append(contentsOf: pills)
        print("Added a new pill: \(pills)")
        tableView.reloadData()
    }
}
