//
//  PillsTableViewExtension.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 14.11.2023.
//

import UIKit
//MARK: table view settings
extension PillsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6 // Общее количество ячеек
    }
    //MARK: - cell for row
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

        default:
            return UITableViewCell()
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
