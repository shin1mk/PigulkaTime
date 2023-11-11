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

final class PillsViewController: UIViewController {
    weak var delegate: PillsViewControllerDelegate?
    private var editingCell: DrugNameCustomTableCell? // изменения ячейки
    private var pillsArray: [Pill] = [] // массив
    
    private let types = ["Pills", "Injections", "Suppositories", "Tablets", "Capsules"]
    private var selectedType: String?

    
    //MARK: Properties
    private let bottomMarginGuide = UILayoutGuide() // нижняя граница
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DrugNameCustomTableCell.self, forCellReuseIdentifier: "DrugNameCustomCell")
        tableView.register(TypeCustomTableCell.self, forCellReuseIdentifier: "TypeCustomCell")
        tableView.register(DosageCustomTableCell.self, forCellReuseIdentifier: "DosageCustomCell")
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
        saveButton.titleLabel?.font = UIFont.SFUITextHeavy(ofSize: 20)
        saveButton.setTitleColor(.white, for: .normal)
        return saveButton
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
        // addButton
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
    @objc private func saveButtonTapped() {
        // Проверяем, что у нас есть ссылка на редактируемую ячейку
        guard let editingCell = editingCell else {
            // В случае, если editingCell равен nil (нет редактируемой ячейки), выходим из метода
            return
        }
        
        // Создаем новый объект Pill на основе введенных данных в текстовое поле
        let newPill = Pill(name: editingCell.textField.text ?? "", dosage: "10mg", type: "Type A", isEditable: true)
        // Добавляем новый объект Pill в массив pillsArray
        pillsArray.append(newPill)
        // Вызываем делегата для передачи обновленного массива
        delegate?.pillsViewController(self, didSavePills: pillsArray)
        // Закрываем текущий контроллер
        dismiss(animated: true, completion: nil)
    }
} //end
//MARK: TableView
//extension PillsViewController: UITableViewDelegate, UITableViewDataSource {
//    // высота
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 45
//    }
//    // кол-во строк
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    //содержимое ячечки
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "DrugNameCustomCell", for: indexPath) as! DrugNameCustomTableCell
//        // если 0 ячейка, то нажимаем тап
//        if indexPath.row == 0 {
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
//            cell.addGestureRecognizer(tapGesture)
//        }
//        return cell
//    }
//    // нажатая ячейка
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Custom cell at index: \(indexPath.row)")
//    }
//    // 0 ячейка нажата вызвали ее редактирование
//    @objc private func cellTapped(_ gesture: UITapGestureRecognizer) {
//        guard let tappedCell = gesture.view as? DrugNameCustomTableCell else { return }
//        editingCell = tappedCell
//        tappedCell.textField.becomeFirstResponder()
//    }
//}
extension PillsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 45 // Высота для первой ячейки
        case 1:
            return 45 // Высота для второй ячейки
        case 2:
            return 45 // Высота для третьей ячейки
        default:
            return 45 // Значение по умолчанию для остальных ячеек
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // Общее количество ячеек
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
        default:
            cellIdentifier = "TypeCustomCell"
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Check if the cell is of type DrugNameCustomTableCell before adding gesture
        if let drugNameCell = cell as? DrugNameCustomTableCell, indexPath.row == 0 {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
            drugNameCell.addGestureRecognizer(tapGesture)
        }
        
        return cell
    }
    
    @objc private func cellTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedCell = gesture.view as? DrugNameCustomTableCell else { return }
        editingCell = tappedCell
        tappedCell.textField.becomeFirstResponder()
    }
}

extension PillsViewController: TypeCustomTableCellDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    func didSelectType(cell: TypeCustomTableCell) {
        // Создайте UIViewController
        let pickerViewController = UIViewController()
        // Создайте UIPickerView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .black
        // Установите размеры UIPickerView
        let pickerViewHeight: CGFloat = 250
        let bottomMargin: CGFloat = 30
        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
        // Добавьте UIPickerView в UIViewController
        pickerViewController.view.addSubview(pickerView)
        // Создайте кнопку "OK" для закрытия пикера
        let okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .black
        okButton.addTarget(self, action: #selector(okButtonTapped(_:)), for: .touchUpInside)

        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 250
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
            return
        }

        // Выведите в консоль выбранный тип
        print("Selected Type: \(selectedType)")
        // Установите выбранный тип в typeLabel
        // Установите выбранный тип в typeLabel в соответствующей ячейке
           if let typeCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TypeCustomTableCell {
               typeCell.setLabelText("\(selectedType)")
           }
        // Закройте UIViewController при нажатии кнопки "OK"
        dismiss(animated: true, completion: nil)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = types[row]
        print("Selected Type: \(selectedType ?? "No type selected")")
    }
    // Методы для UIPickerViewDelegate и UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return types[row]
    }
   
}

