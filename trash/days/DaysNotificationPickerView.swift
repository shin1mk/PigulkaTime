////
////  DaysNotificationPickerView.swift
////  PigulkaTime
////
////  Created by SHIN MIKHAIL on 23.11.2023.
////
//
//import UIKit
//
//extension NotificationsViewController {
//    // MARK: - Days Picker
//    func didSelectDays(cell: DaysNotificationTableCell) {
//        let pickerViewController = createPickerViewController()
//        present(pickerViewController, animated: true, completion: nil)
//    }
//    
//    private func createPickerViewController() -> UIViewController {
//        let pickerViewController = UIViewController()
//        let pickerView = createPickerView(for: pickerViewController)
//        let okButton = createDaysOkButton(for: pickerViewController)
//        
//        pickerViewController.view.addSubview(pickerView)
//        pickerViewController.view.addSubview(okButton)
//        pickerViewController.modalPresentationStyle = .overCurrentContext
//        
//        return pickerViewController
//    }
//    
//    private func createPickerView(for pickerViewController: UIViewController) -> UIPickerView {
//        let pickerView = UIPickerView()
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        pickerView.tag = 5 // For Type picker view
//        pickerView.backgroundColor = .black
//        pickerView.selectRow(0, inComponent: 0, animated: false)
//        
//        let pickerViewHeight: CGFloat = 340
//        let bottomMargin: CGFloat = 30
//        pickerView.frame = CGRect(x: 0, y: pickerViewController.view.bounds.height - pickerViewHeight - bottomMargin, width: pickerViewController.view.bounds.width, height: pickerViewHeight)
//        
//        return pickerView
//    }
//    
//    private func createDaysOkButton(for pickerViewController: UIViewController) -> UIButton {
//        let okButton = UIButton(type: .system)
//        okButton.setTitle("OK", for: .normal)
//        okButton.titleLabel?.font = UIFont.SFUITextMedium(ofSize: 18)
//        okButton.setTitleColor(.white, for: .normal)
//        okButton.backgroundColor = .systemGray6
//        okButton.addTarget(self, action: #selector(daysOkButtonTapped(_:)), for: .touchUpInside)
//        
//        let bottomMargin: CGFloat = 30
//        let okButtonY = pickerViewController.view.bounds.height - bottomMargin - 340
//        okButton.frame = CGRect(x: 0, y: okButtonY, width: pickerViewController.view.bounds.width, height: 50)
//        
//        return okButton
//    }
//    // daysOkButtonTapped
//    @objc private func daysOkButtonTapped(_ sender: UIButton) {
//        // выбранный тип в typeLabel
//        if let daysCell = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? DaysNotificationTableCell {
//            daysCell.setDaysText("1")
//        }
//      
//        // Закройте UIViewController при нажатии кнопки "OK"
//        dismiss(animated: true, completion: nil)
//    }
//}
