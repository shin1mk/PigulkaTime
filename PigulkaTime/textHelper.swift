//
//  textHelper.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 07.11.2023.
//

/*
 //MARK: TableView
 extension PillsViewController: UITableViewDelegate, UITableViewDataSource {
     // heightForRowAt
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 70
     }
     // numberOfRowsInSection
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 9
     }
     //MARK: cellForRowAt
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "PillCustomCell", for: indexPath) as! PillViewCustomTableCell
         // Вызов setPlaceholderVisible для управления видимостью placeholder в текстовом поле
         cell.setPlaceholderVisible(indexPath.row == 0)
       
         if indexPath.row == 0 {
             let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped(_:)))
             cell.addGestureRecognizer(tapGesture)
         }
         return cell
     }
     // Обработчик события касания
     @objc private func cellTapped(_ gesture: UITapGestureRecognizer) {
         guard let tappedCell = gesture.view as? PillViewCustomTableCell else { return }
         tappedCell.textField.becomeFirstResponder()
     }
     //MARK: didSelectRowAt
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         print("Custom cell at index: \(indexPath.row)")
     }
 }

 
 // общий метод для установки текста в titleLabel
//    func setTitleLabelText(_ text: String) {
//        titleLabel.text = text
//    }
//    func setDosageLabelText(_ text: String) {
//        dosageLabel.text = text
//    }
//    func setTypeLabelText(_ text: String) {
//        typeLabel.text = text
//    }
//    func setDateLabelText(_ text: String) {
//        dateLabel.text = text
//    }
//protocol CustomTableViewCellDelegate: AnyObject {
//    func setLabelText(_ text: String)
//    func setTitleLabelText(_ text: String)
//    func setDosageLabelText(_ text: String)
//    func setTypeLabelText(_ text: String)
//    func setDateLabelText(_ text: String)
//}

 */
