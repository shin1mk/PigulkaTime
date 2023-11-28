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

final class PillsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    weak var delegate: PillsViewControllerDelegate?
    var editingPill: Pigulka? // Переменная для хранения данных, которые нужно редактировать
    convenience init(pill: Pigulka) {
        self.init()
        self.editingPill = pill
    }
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
    public let days: [String] = ["1 day", "2 days", "3 days", "4 days", "5 days", "6 days", "7 days", "10 days", "14 days", "30 days", "60 days", "90 days"]
    public var selectedDays: String?
    // for times per day picker view
    public let times: [String] = (1...10).map { "\($0)" }
    public var selectedTimes: String?

    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DrugNameCustomTableCell.self, forCellReuseIdentifier: "DrugNameCustomCell")
        tableView.register(TypeCustomTableCell.self, forCellReuseIdentifier: "TypeCustomCell")
        tableView.register(DosageCustomTableCell.self, forCellReuseIdentifier: "DosageCustomCell")
        tableView.register(FrequencyCustomTableCell.self, forCellReuseIdentifier: "FrequencyCustomCell")
        tableView.register(DaysCustomTableCell.self, forCellReuseIdentifier: "DaysCustomCell")
        tableView.register(TimesCustomTableCell.self, forCellReuseIdentifier: "TimesCustomCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    //MARK: Properties
    private let bottomMarginGuide = UILayoutGuide() // нижняя граница
    private let subtractImageView = UIImageView(image: UIImage(named: "subtract"))
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
        setupEditPill()
    }
    
    func setupEditPill() {
        if let editingPill = editingPill {
            // Заполняем соответствующие переменные значениями из editingPill
            selectedType = editingPill.type
            selectedDosage = editingPill.dosage
            selectedFrequency = editingPill.frequency
            selectedTimes = editingPill.times
            if let daysLeft = editingPill.days?.replacingOccurrences(of: " days left", with: ""),
               let daysInt = Int(daysLeft) {
                selectedDays = "\(daysInt) days left"
            }
            // Принты для отслеживания данных
            print("Selected Type: \(selectedType ?? "N/A")")
            print("Selected Dosage: \(selectedDosage ?? "N/A")")
            print("Selected Frequency: \(selectedFrequency ?? "N/A")")
            print("Selected Days: \(selectedDays ?? "N/A")")
            print("Selected Times: \(selectedTimes ?? "N/A")")
            
            // Заполняем значения в соответствующих ячейках
            if let typeCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TypeCustomTableCell {
                typeCell.setLabelText(selectedType ?? "")
            }
            if let dosageCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? DosageCustomTableCell {
                dosageCell.setDosageText(selectedDosage ?? "")
            }
            if let frequencyCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? FrequencyCustomTableCell {
                frequencyCell.setFrequencyText(selectedFrequency ?? "")
            }
            if let daysCell = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? DaysCustomTableCell {
                daysCell.setDaysText(selectedDays ?? "")
            }
            if let timesCell = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? TimesCustomTableCell {
                timesCell.setTimesText(selectedTimes ?? "")
            }
        }
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
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
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
    @objc private func saveButtonTapped(_ sender: UIButton) {
        guard let editingCell = editingCell,
              let selectedType = selectedType,
              let selectedDosage = selectedDosage,
              let selectedFrequency = selectedFrequency,
              let selectedDaysString = selectedDays else {
            // Обработка случая, когда какие-то из полей не выбраны
            print("Some fields are not selected.")
            return
        }
        
        let cleanedSelectedDaysString = selectedDaysString.replacingOccurrences(of: "days", with: "").trimmingCharacters(in: .whitespaces)
        guard let selectedDays = Int(cleanedSelectedDaysString) else {
            print("Invalid or non-integer value for selectedDays: \(cleanedSelectedDaysString)")
            return
        }
        print("Selected days: \(selectedDays)")
        if let daysCell = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? DaysCustomTableCell {
            daysCell.setDaysText("\(selectedDays)")
        }
        // Print or use the selectedTime and selectedFrequency as needed
        print("Selected Frequency: \(selectedFrequency)")
     
        let newPill = Pill(
            name: editingCell.textField.text ?? "",
            dosage: selectedDosage,
            type: selectedType,
            frequency: selectedFrequency,
            days: "\(selectedDays) days left",
            times: "\(selectedTimes ?? "no")",
            isEditable: true,
            identifier: ""
        )
        // Добавляем новый объект Pill в массив pillsArray
        pillsArray.append(newPill)
        // Вызываем делегата для передачи обновленного массива
        delegate?.pillsViewController(self, didSavePills: pillsArray)
        
        editingCell.textField.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    // Вспомогательная функция для получения даты из выбранного времени
    private func getSelectedTimeDate(selectedTime: String) -> Date? {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let timeComponents = selectedTime.components(separatedBy: ":")
        guard let hour = Int(timeComponents[0]), let minute = Int(timeComponents[1]) else {
            print("Invalid time format.")
            return nil
        }
        
        var dateComponents = calendar.dateComponents([.year, .month, .day], from: currentDate)
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = 0
        
        return calendar.date(from: dateComponents)
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
