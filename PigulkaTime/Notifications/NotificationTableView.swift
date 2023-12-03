//
//  NotificationTableView.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    // высотка ячейки
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    // количество ячеек
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    // каждая ячейка
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCustomTableCell", for: indexPath) as! FirstCustomTableCell
            cell.delegate = self
            cell.tag = 0
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCustomTableCell", for: indexPath) as! SecondCustomTableCell
            cell.delegate = self
            cell.tag = 1
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdCustomTableCell", for: indexPath) as! ThirdCustomTableCell
            cell.delegate = self
            cell.tag = 2
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FourthCustomTableCell", for: indexPath) as! FourthCustomTableCell
            cell.delegate = self
            cell.tag = 3
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FifthCustomTableCell", for: indexPath) as! FifthCustomTableCell
            cell.delegate = self
            cell.tag = 4
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SixthCustomTableCell", for: indexPath) as! SixthCustomTableCell
            cell.delegate = self
            cell.tag = 5
            return cell
        default:
            return UITableViewCell()
        }
    }
    // устанавливаем clear цвет для выделения
      func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          cell.selectionStyle = .none
      }
} // end
