//
//  PillsViewController.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 10.11.2023.
//

import UIKit
import SnapKit
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
protocol StartingCustomTableCellDelegate: AnyObject {
    func didSelectStarting(cell: StartingCustomTableCell)
}

final class PillsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, StartingCustomTableCellDelegate {
    
    weak var delegate: PillsViewControllerDelegate?
    private var editingCell: DrugNameCustomTableCell? // изменения ячейки
    private var pillsArray: [Pill] = [] // массив
    // for type picker view
    private let types = ["", "Pills", "Injections", "Suppositories", "Tablets", "Capsules", "Syrups", "Drops", "Ointments", "Sprays", "Lozenges", "Inhalers"]
    private var selectedType: String?
    // for dosage picker view
    private let dosages = ["", "0.25", "0.5", "1", "1.5", "2", "2.5", "3", "4", "5", "10", "15", "20", "25", "30"]
    private var selectedDosage: String?
    // for frequency picker view
    private let frequency = ["", "Daily", "Every Hour", "Every 2 hours", "Every 3 hours", "Every 4 hours", "Every 6 hours", "Every 8 hours", "Every 12 hours", "Every Day", "Every 2 days", "Every 3 days", "Every 4 days", "Every 5 days", "Every 6 days", "Weekly", "Every 2 weeks", "Every 3 weeks", "Monthly", "Every 2 months", "Every 3 months"]
    private var selectedFrequency: String?
    // for days picker view
    private let days: [String] = (0...100).map { "\($0) day\($0 == 1 ? "" : "s")" }
    private var selectedDays: String?
    // for times per day picker view
    private let times: [String] = (0...10).map { "\($0)" }
    private var selectedTimes: String?
    // for starting picker view
    private let starting: [String] = {
        var times = [String]()
        for hour in 0...23 {
            for minute in stride(from: 0, through: 55, by: 5) {
                times.append(String(format: "%02d:%02d", hour, minute))
            }
        }
        return times
    }()

    private var selectedStarting: String?
    
    //MARK: Properties
    private let bottomMarginGuide = UILayoutGuide() // нижняя граница
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DrugNameCustomTableCell.self, forCellReuseIdentifier: "DrugNameCustomCell")
        tableView.register(TypeCustomTableCell.self, forCellReuseIdentifier: "TypeCustomCell")
        tableView.register(DosageCustomTableCell.self, forCellReuseIdentifier: "DosageCustomCell")
        tableView.register(FrequencyCustomTableCell.self, forCellReuseIdentifier: "FrequencyCustomCell")
        tableView.register(DaysCustomTableCell.self, forCellReuseIdentifier: "DaysCustomCell")
        tableView.register(TimesCustomTableCell.self, forCellReuseIdentifier: "TimesCustomCell")
        tableView.register(StartingCustomTableCell.self, forCellReuseIdentifier: "StartingCustomCell")
        return tableView
    }()
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
    }
    //MARK: Constraints
    private func setupConstraints() {
        view.backgroundColor = .black
        // titleLabel
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
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
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
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
//    @objc private func saveButtonTapped() {
//        // Проверяем, что у нас есть ссылка на редактируемую ячейку
//        guard let editingCell = editingCell else {
//            // В случае, если editingCell равен nil (нет редактируемой ячейки), выходим из метода
//            return
//        }
//        // Создаем новый объект Pill на основе введенных данных в текстовое поле и выбранного типа
//        let newPill = Pill(name: editingCell.textField.text ?? "",
//                           dosage: selectedDosage ?? "",
//                           type: selectedType ?? "",
//                           frequency: selectedFrequency ?? "",
//                           days: selectedDays! + " left",
//                           times: selectedTimes! + " times",
//                           isEditable: true)
//        // Добавляем новый объект Pill в массив pillsArray
//        pillsArray.append(newPill)
//        // Вызываем делегата для передачи обновленного массива
//        delegate?.pillsViewController(self, didSavePills: pillsArray)
//        // Закрываем текущий контроллер
//        dismiss(animated: true, completion: nil)
//    }
    @objc private func saveButtonTapped() {
        // Проверяем, что у нас есть ссылка на редактируемую ячейку
        guard let editingCell = editingCell else {
            // В случае, если editingCell равен nil (нет редактируемой ячейки), выходим из метода
            return
        }

        // Проверяем, что все обязательные поля заполнены
        guard let name = editingCell.textField.text, !name.isEmpty,
              let selectedDosage = selectedDosage, !selectedDosage.isEmpty,
              let selectedType = selectedType, !selectedType.isEmpty,
              let selectedFrequency = selectedFrequency, !selectedFrequency.isEmpty,
              let selectedDays = selectedDays, !selectedDays.isEmpty,
              let selectedTimes = selectedTimes, !selectedTimes.isEmpty else {
            // Если хотя бы одно из обязательных полей пусто, выходим из метода
            return
        }

        // Создаем новый объект Pill на основе введенных данных в текстовое поле и выбранного типа
        let newPill = Pill(name: name,
                           dosage: selectedDosage,
                           type: selectedType,
                           frequency: selectedFrequency,
                           days: selectedDays + " left",
                           times: selectedTimes + " times",
                           isEditable: true)

        // Добавляем новый объект Pill в массив pillsArray
        pillsArray.append(newPill)

        // Вызываем делегата для передачи обновленного массива
        delegate?.pillsViewController(self, didSavePills: pillsArray)

        // Закрываем текущий контроллер
        dismiss(animated: true, completion: nil)
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
//MARK: TableView
extension PillsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Общее количество ячеек
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier: String
        switch indexPath.row {
        case 0:
            cellIdentifier = "DrugNameCustomCell"
        case 1:
            cellIdentifier = "TypeCustomCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TypeCustomTableCell
            cell.delegate = self
            return cell
        case 2:
            cellIdentifier = "DosageCustomCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DosageCustomTableCell
            cell.delegate = self
            return cell
        case 3:
            cellIdentifier = "FrequencyCustomCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FrequencyCustomTableCell
            cell.delegate = self
            return cell
        case 4:
            cellIdentifier = "DaysCustomCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DaysCustomTableCell
            cell.delegate = self
            return cell
        case 5:
            cellIdentifier = "TimesCustomCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TimesCustomTableCell
            cell.delegate = self
            return cell
        case 6:
            cellIdentifier = "StartingCustomCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StartingCustomTableCell
            cell.delegate = self
            return cell
        default:
            cellIdentifier = "TypeCustomCell"
        }
        // for cell DrugNameCustomCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let drugNameCell = cell as? DrugNameCustomTableCell, indexPath.row == 0 {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
            drugNameCell.addGestureRecognizer(tapGesture)
        }
        
        return cell
    }
    // tap cell == 0
    @objc private func cellTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedCell = gesture.view as? DrugNameCustomTableCell else { return }
        editingCell = tappedCell
        tappedCell.textField.becomeFirstResponder()
    }
}
//MARK: Type picker view
extension PillsViewController: TypeCustomTableCellDelegate {
    func didSelectType(cell: TypeCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 1 // Для Type picker view
        pickerView.backgroundColor = .black
        // Добавьте эту строку, чтобы выбрать первое значение
        pickerView.selectRow(0, inComponent: 0, animated: false)

        // Установите размеры UIPickerView
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        // Добавьте UIPickerView в UIViewController
        pickerViewController.view.addSubview(pickerView)
        // Создайте кнопку "OK" для закрытия пикера
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(okButtonTapped(_:)), for: .touchUpInside)
        
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        // Добавьте кнопку в UIViewController
        pickerViewController.view.addSubview(okButton)
        // Отобразите UIViewController модально
        pickerViewController.modalPresentationStyle = .overCurrentContext
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc private func okButtonTapped(_ sender: UIButton) {
        // Получите выбранный тип из свойства selectedType
        guard let selectedType = selectedType else {
            print("No type selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        // Выведите в консоль выбранный тип
        print("Selected Type: \(selectedType)")
        // выбранный тип в typeLabel
        if let typeCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TypeCustomTableCell {
            typeCell.setLabelText("\(selectedType)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
}
//MARK: Dosage picker view
extension PillsViewController: DosageCustomTableCellDelegate {
    func didSelectDosage(cell: DosageCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 2 // Для Type picker view
        pickerView.backgroundColor = .black
        // Установите размеры UIPickerView
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        // Добавьте UIPickerView в UIViewController
        pickerViewController.view.addSubview(pickerView)
        // Создайте кнопку "OK" для закрытия пикера
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(dosageOkButtonTapped(_:)), for: .touchUpInside)
        
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        // Добавьте кнопку в UIViewController
        pickerViewController.view.addSubview(okButton)
        // Отобразите UIViewController модально
        pickerViewController.modalPresentationStyle = .overCurrentContext
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc private func dosageOkButtonTapped(_ sender: UIButton) {
        // Получите выбранный тип из свойства selectedType
        guard let selectedDosage = selectedDosage else {
            print("No type selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        // Выведите в консоль выбранный тип
        print("Selected Dosage: \(selectedDosage)")
        // выбранный тип в typeLabel
        if let typeCell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? DosageCustomTableCell {
            typeCell.setDosageText("\(selectedDosage)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
}
//MARK: Frequency picker view
extension PillsViewController: FrequencyCustomTableCellDelegate {
    func didSelectFrequency(cell: FrequencyCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 3 // Для Type picker view
        pickerView.backgroundColor = .black
        // Установите размеры UIPickerView
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        // Добавьте UIPickerView в UIViewController
        pickerViewController.view.addSubview(pickerView)
        // Создайте кнопку "OK" для закрытия пикера
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(frequencyOkButtonTapped(_:)), for: .touchUpInside)
        
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        // Добавьте кнопку в UIViewController
        pickerViewController.view.addSubview(okButton)
        // Отобразите UIViewController модально
        pickerViewController.modalPresentationStyle = .overCurrentContext
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc private func frequencyOkButtonTapped(_ sender: UIButton) {
        // Получите выбранный тип из свойства selectedType
        guard let selectedFrequency = selectedFrequency else {
            print("No type selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        // Выведите в консоль выбранный тип
        print("Selected Frequency: \(selectedFrequency)")
        // выбранный тип в typeLabel
        if let typeCell = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? FrequencyCustomTableCell {
            typeCell.setFrequencyText("\(selectedFrequency)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
}
//MARK: Days picker view
extension PillsViewController: DaysCustomTableCellDelegate {
    func didSelectDays(cell: DaysCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 4 // Для Type picker view
        pickerView.backgroundColor = .black
        // Установите размеры UIPickerView
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        // Добавьте UIPickerView в UIViewController
        pickerViewController.view.addSubview(pickerView)
        // Создайте кнопку "OK" для закрытия пикера
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(daysOkButtonTapped(_:)), for: .touchUpInside)
        
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        // Добавьте кнопку в UIViewController
        pickerViewController.view.addSubview(okButton)
        // Отобразите UIViewController модально
        pickerViewController.modalPresentationStyle = .overCurrentContext
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc private func daysOkButtonTapped(_ sender: UIButton) {
        // Получите выбранный тип из свойства selectedType
        guard let selectedDays = selectedDays else {
            print("No type selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        // Выведите в консоль выбранный тип
        print("Selected days: \(selectedDays)")
        // выбранный тип в typeLabel
        if let typeCell = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? DaysCustomTableCell {
            typeCell.setDaysText("\(selectedDays)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
}
//MARK: Times per day picker view
extension PillsViewController: TimesCustomTableCellDelegate {
    func didSelectTimes(cell: TimesCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 5
        pickerView.backgroundColor = .black
        // Установите размеры UIPickerView
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        // Добавьте UIPickerView в UIViewController
        pickerViewController.view.addSubview(pickerView)
        // Создайте кнопку "OK" для закрытия пикера
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(timesOkButtonTapped(_:)), for: .touchUpInside)
        
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        // Добавьте кнопку в UIViewController
        pickerViewController.view.addSubview(okButton)
        // Отобразите UIViewController модально
        pickerViewController.modalPresentationStyle = .overCurrentContext
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc private func timesOkButtonTapped(_ sender: UIButton) {
        // Получите выбранный тип из свойства selectedType
        guard let selectedTimes = selectedTimes else {
            print("No times selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        // Выведите в консоль выбранный тип
        print("Selected times: \(selectedTimes)")
        // выбранный тип в typeLabel
        if let typeCell = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? TimesCustomTableCell {
            typeCell.setTimesText("\(selectedTimes)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
}
//MARK: starting picker view
extension PillsViewController {
    func didSelectStarting(cell: StartingCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tag = 6
        pickerView.backgroundColor = .black
        pickerView.reloadComponent(0) // 0 — это индекс компонента часов
        pickerView.reloadComponent(1) // 1 — это индекс компонента минут

        // Установите размеры UIPickerView
        let pickerViewHeight: CGFloat = 340
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        // Добавьте UIPickerView в UIViewController
        pickerViewController.view.addSubview(pickerView)
        // Создайте кнопку "OK" для закрытия пикера
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .systemGray6
        okButton.addTarget(self, action: #selector(startingOkButtonTapped(_:)), for: .touchUpInside)
        
        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
        // Добавьте кнопку в UIViewController
        pickerViewController.view.addSubview(okButton)
        // Отобразите UIViewController модально
        pickerViewController.modalPresentationStyle = .overCurrentContext
        present(pickerViewController, animated: true, completion: nil)
    }
    
    @objc private func startingOkButtonTapped(_ sender: UIButton) {
        // Получите выбранный тип из свойства selectedType
        guard let selectedStarting = selectedStarting else {
            print("No times selected.")
            dismiss(animated: true, completion: nil)
            return
        }
        // Выведите в консоль выбранный тип
        print("Selected starting at: \(selectedStarting)")
        // выбранный тип в typeLabel
        if let typeCell = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? StartingCustomTableCell {
            typeCell.setStartingText("\(selectedStarting)")
        }
        // Снимите фокус с текстового поля
        editingCell?.textField.resignFirstResponder()
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }
}
//MARK: Settings Picker view
extension PillsViewController {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            selectedType = types[row]
            print("Selected Type: \(selectedType ?? "No type selected")")
        case 2:
            selectedDosage = dosages[row]
            print("Selected Dosage: \(selectedDosage ?? "No dosage selected")")
        case 3:
            selectedFrequency = frequency[row]
            print("Selected Frequency: \(selectedFrequency ?? "No frequency selected")")
        case 4:
            selectedDays = days[row]
            print("Selected Days: \(selectedDays ?? "No days selected")")
        case 5:
            selectedTimes = times[row]
            print("Selected Days: \(selectedTimes ?? "No times selected")")
        case 6:
            if component == 0 {
                   // Выбран час
                   let selectedHour = row
                   let selectedMinute = pickerView.selectedRow(inComponent: 1) * 5
                   selectedStarting = String(format: "%02d:%02d", selectedHour, selectedMinute)
               } else {
                   // Выбраны минуты
                   let selectedHour = pickerView.selectedRow(inComponent: 0)
                   let selectedMinute = row * 5
                   selectedStarting = String(format: "%02d:%02d", selectedHour, selectedMinute)
               }
               print("Selected Starting at: \(selectedStarting ?? "No starting at selected")")
        default:
            break
        }
    }
    // Методы для UIPickerViewDelegate и UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        switch pickerView.tag {
        case 1:
            return 1
        case 2:
            return 1
        case 3:
            return 1
        case 4:
            return 1
        case 5:
            return 1
        case 6:
            return 2
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return types.count
        case 2:
            return dosages.count
        case 3:
            return frequency.count
        case 4:
            return days.count
        case 5:
            return times.count
        case 6:
            if component == 0 {
                return 24 // Часы от 0 до 23
            } else {
                return 12 // Минуты от 0 до 55 с шагом 5
            }
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return types[row]
        case 2:
            return dosages[row]
        case 3:
            return frequency[row]
        case 4:
            return days[row]
        case 5:
            return times[row]
        case 6:
            if component == 0 {
                return String(format: "%02d", row) // Форматирование часов
            } else {
                return String(format: "%02d", row * 5) // Форматирование минут с шагом 5
            }
        default:
            return nil
        }
    }
}
