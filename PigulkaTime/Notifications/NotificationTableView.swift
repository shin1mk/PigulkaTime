//
//  NotificationTableView.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 23.11.2023.
//

import UIKit

extension NotificationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
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
        default:
            return UITableViewCell()
        }
    }

}
