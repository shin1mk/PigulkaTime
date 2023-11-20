//
//  ViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 07.11.2023.
//

import UIKit
import SnapKit
import UserNotifications

final class MainViewController: UIViewController {
//    public var pillsArray: [Pill] = [] // массив таблеток
    private var pillsArray: [Pigulka] = []
    let coreDataManager = CoreDataManager.shared
    private var pillsViewController: PillsViewController?

    private let feedbackGenerator = UISelectionFeedbackGenerator() // виброотклик
    private let bottomMarginGuide = UILayoutGuide() // нижняя граница
    //MARK: Properties
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(MainViewCustomTableCell.self, forCellReuseIdentifier: "MainCustomCell")
        return tableView
    }()
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Pills"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextHeavy(ofSize: 45)
        return titleLabel
    }()
    private let emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.text = "Your pill box is empty"
        emptyLabel.textColor = .white
        emptyLabel.textAlignment = .left
        emptyLabel.font = UIFont.SFUITextBold(ofSize: 18)
        return emptyLabel
    }()
    private let addButton: UIButton = {
        let addButton = UIButton()
        let plusFillImage = UIImage(systemName: "plus.circle.fill")?
            .withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        addButton.setImage(plusFillImage, for: .normal)
        addButton.setTitle(" Add pills", for: .normal)
        addButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 20)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemGray6
        addButton.layer.cornerRadius = 5
        return addButton
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
        setupTarget()
        coreDataLoad()
        // Инициализация pillsViewController
//         pillsViewController = PillsViewController()
//         pillsViewController?.modalPresentationStyle = .popover
//         pillsViewController?.delegate = self
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
        // emptyLabel
        view.addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        // tableView
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
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
    // coreData download
    private func coreDataLoad() {
        pillsArray = CoreDataManager.shared.loadPillsFromCoreData()
        self.emptyLabel.isHidden = !self.pillsArray.isEmpty
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
        return 70
    }
    // кол-во строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pillsArray.count
    }
    // содержимое ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCustomCell", for: indexPath) as! MainViewCustomTableCell
        // фон ячейки
        let backgroundCellColor = UIView()
        backgroundCellColor.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundCellColor
        // установим title в ячейку
        let pill = pillsArray[indexPath.row]
        cell.setTitleLabelText(pill.name ?? "")
        cell.setTypeLabelText(pill.type ?? "")
        cell.setDosageLabelText(pill.dosage ?? "")
        cell.setFrequencyLabelText(pill.frequency ?? "")
        cell.setDaysLabelText(pill.days ?? "")
        cell.setTimesLabelText(pill.times ?? "")
        cell.setTimeLabelText(pill.time ?? "")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        let selectedPill = pillsArray[indexPath.row]

        if pillsViewController == nil {
            // Инициализация pillsViewController, если он еще не инициализирован
            pillsViewController = PillsViewController()
            pillsViewController?.modalPresentationStyle = .popover
            pillsViewController?.delegate = self
        }

        // Задайте свойство editingPill вашего PillsViewController, чтобы передать данные для редактирования
        pillsViewController?.editingPill = selectedPill

        // Представьте ваш PillsViewController только если он не был представлен ранее
        if pillsViewController?.isBeingPresented == false {
            present(pillsViewController!, animated: true) {
                self.pillsViewController?.setupEditPill()
            }
        }
    }
    // swipe to delete func
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard !pillsArray.isEmpty else {
            return nil
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
            guard let self = self else { return }

            // Получаем объект, который нужно удалить
            let pillToRemove = self.pillsArray[indexPath.row]

            // Создайте алерт для подтверждения удаления
            let alertController = UIAlertController(
                title: "Delete Pill",
                message: "Are you sure you want to delete this pill?",
                preferredStyle: .alert
            )

            // Добавьте действие для подтверждения
            alertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
                guard let self = self else { return }

                // Удаляем объект из массива данных
                self.pillsArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)

                // Удаляем объект из Core Data
                self.coreDataManager.deletePillFromCoreData(pill: pillToRemove)

                completionHandler(true)

                // Update the isEmpty property and hide/show the emptyLabel accordingly
                self.emptyLabel.isHidden = !self.pillsArray.isEmpty
            }))

            // Добавьте действие для отмены
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                completionHandler(false) // Отменить удаление
            }))

            // Представьте алерт
            self.present(alertController, animated: true, completion: nil)
        }
        
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.title = nil
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false

        return configuration
    }


}
//MARK: открытая функция добавляет в массив данные из PillsViewControler и сохранять в coredata
extension MainViewController: PillsViewControllerDelegate {
    func pillsViewController(_ controller: PillsViewController, didSavePills pills: [Pill]) {
        for pill in pills {
            // Преобразуем строку "0 days left" в Int
            let daysInt: Int = {
                let digits = pill.days.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                return Int(digits ) ?? 0
            }()
            pillsViewController = controller

            CoreDataManager.shared.savePillToCoreData(name: pill.name ?? "",
                                                      selectedDosage: pill.dosage,
                                                      selectedType: pill.type,
                                                      selectedFrequency: pill.frequency,
                                                      selectedDays: daysInt,
                                                      selectedTimes: pill.times,
                                                      selectedTime: pill.time)
        }
        // Загрузите обновленные таблетки из Core Data
        print("Before: \(pillsArray)")
        pillsArray = CoreDataManager.shared.loadPillsFromCoreData()
        print("After: \(pillsArray)")

        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.emptyLabel.isHidden = !self.pillsArray.isEmpty
        }
    }
}
