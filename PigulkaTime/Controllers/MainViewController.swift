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
    private var pillsArray: [Pigulka] = [] // массив с данными
    private let coreDataManager = CoreDataManager.shared
    private var pillsViewController: PillsViewController?
    private var notificationsViewController: NotificationsViewController?
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
        titleLabel.text = "main_titleLabel".localized();
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.SFUITextHeavy(ofSize: 45)
        return titleLabel
    }()
    private let emptyLabel: UILabel = {
        let emptyLabel = UILabel()
        emptyLabel.text = "main_emptyLabel".localized();
        emptyLabel.textColor = .white
        emptyLabel.textAlignment = .left
        emptyLabel.font = UIFont.SFUITextBold(ofSize: 18)
        return emptyLabel
    }()
    private let addButton: UIButton = {
        let addButton = UIButton()
        let plusFillImage = UIImage(systemName: "plus.circle.fill")?
            .withTintColor(UIColor.red, renderingMode: .alwaysOriginal)
        addButton.setImage(plusFillImage, for: .normal)
        addButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 14)
        addButton.setTitle("main_addButton".localized(), for: .normal)
        addButton.titleLabel?.font = UIFont.SFUITextBold(ofSize: 22)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemGray6
        addButton.layer.cornerRadius = 10
        return addButton
    }()
    private let notificationsButton: UIButton = {
        let notificationsButton = UIButton()
        let bellFillImage = UIImage(systemName: "bell.fill")?
            .withTintColor(UIColor.white, renderingMode: .alwaysOriginal)
        notificationsButton.setImage(bellFillImage, for: .normal)
        return notificationsButton
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setupTableView()
        setupTarget()
        coreDataLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear - MainViewController")
        coreDataLoad()
        tableView.reloadData()
        print("Data reloaded - MainViewController")
        print("Number of pills: \(pillsArray.count)")
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
        // notificationsButton
        view.addSubview(notificationsButton)
        notificationsButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.width.equalTo(50)
            make.height.equalTo(60)
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
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
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
        notificationsButton.addTarget(self, action: #selector(notificationsButtonTapped), for: .touchUpInside)
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
    // notification кнопка
    @objc private func notificationsButtonTapped() {
        feedbackGenerator.selectionChanged()
        // открываем модальное окно
        let notificationsViewController = NotificationsViewController()
        notificationsViewController.modalPresentationStyle = .popover
        present(notificationsViewController, animated: true, completion: nil)
    }
} // end
//MARK: TableView
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    // высота
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
        // Рассчитываем конечную дату
        if let daysString = pill.days, let daysInt = Int(daysString) {
            let remainingDays = calculateRemainingDays(startDate: pill.startDate, numberOfDays: daysInt)
            cell.setDaysLabelText("\(remainingDays)" + "main_setDaysLabelText".localized())
        } else {
            cell.setDaysLabelText("N/A") // или другое значение по умолчанию
        }

        cell.setTimesLabelText("\(pill.times!)" + "main_setTimesLabelText".localized())
        return cell
    }
    // рассчет дней прошедших и оставшихся
    func calculateRemainingDays(startDate: Date?, numberOfDays: Int) -> Int {
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .day, value: numberOfDays, to: startDate ?? Date()) ?? Date()
        let remainingDays = calendar.dateComponents([.day], from: Date(), to: endDate).day ?? 0
        return remainingDays
    }
    // нажатая ячейка открывает пилс заполненный
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
        let selectedPill = pillsArray[indexPath.row]
        
        if pillsViewController == nil {
            pillsViewController = PillsViewController()
            pillsViewController?.modalPresentationStyle = .popover
            pillsViewController?.delegate = self
        }
        
        pillsViewController?.editingPill = selectedPill
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
                title: "deleteTitle".localized(),
                message: "deleteMessage".localized(),
                preferredStyle: .alert
            )
            alertController.addAction(UIAlertAction(title: "deleteAction".localized(), style: .destructive, handler: { [weak self] _ in
                guard let self = self else { return }
                // Удаляем объект из массива данных
                self.pillsArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                // Удаляем уведомления
                print("Pill removed: \(pillToRemove)")
                print("Pills array after removal: \(self.pillsArray)")
                // Удаляем объект из Core Data
                self.coreDataManager.deletePillFromCoreData(pill: pillToRemove)
                completionHandler(true)
                // Обновляем видимость emptyLabel
                self.emptyLabel.isHidden = !self.pillsArray.isEmpty
            }))
            
            alertController.addAction(UIAlertAction(title: "deleteCancel".localized(), style: .cancel, handler: { _ in
                completionHandler(false) // Отменить удаление
            }))
            self.present(alertController, animated: true, completion: nil)
        }
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash.fill")
        deleteAction.title = ""
        
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
                return Int(digits) ?? 0
            }()
            pillsViewController = controller
            
            CoreDataManager.shared.savePillToCoreData(name: pill.name ,
                                                      selectedDosage: pill.dosage,
                                                      selectedType: pill.type,
                                                      selectedFrequency: pill.frequency,
                                                      selectedDays: daysInt,
                                                      selectedTimes: pill.times,
                                                      startDate: Date()) // Текущая дата
        }
        print("Before: \(pillsArray)")
        pillsArray = CoreDataManager.shared.loadPillsFromCoreData()
        print("After: \(pillsArray)")
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.emptyLabel.isHidden = !self.pillsArray.isEmpty
        }
    }
}
