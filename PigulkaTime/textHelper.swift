//
//  textHelper.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 07.11.2023.
//

/*
 
 - [ ] Открывать уже заполненные поля для каждой таблетки
 - [ ] Починить кор дата что б удалялось уведомление когда удаляю таблетку
 - [ ] Починить уведомления на завтрашний день

 

 
 Да, если вы хотите, чтобы изменения в Core Data были отражены в вашем основном контроллере после удаления данных из PillsViewController, вы можете использовать делегат (как вы уже сделали для добавления данных). Вот как вы можете это сделать:

 В вашем PillsViewController создайте протокол делегата для обновления данных в основном контроллере:
 swift
 Copy code
 protocol PillsViewControllerDelegate: AnyObject {
     func pillsViewController(_ controller: PillsViewController, didUpdatePills pills: [Pill])
 }
 В том же файле PillsViewController, добавьте свойство делегата:
 swift
 Copy code
 weak var delegate: PillsViewControllerDelegate?
 В методе удаления данных (в вашем методе deleteButtonTapped), вызовите делегата для уведомления основного контроллера о необходимости обновления данных:
 swift
 Copy code
 // В методе deleteButtonTapped
 // ...

 // Удалите данные из Core Data
 if let editingPill = self.editingPill {
     CoreDataManager.shared.deletePillFromCoreData(pill: editingPill)

     // Уведомите делегата об обновлении данных
     delegate?.pillsViewController(self, didUpdatePills: CoreDataManager.shared.loadPillsFromCoreData())
 }

 // Закройте PillsViewController
 self.dismiss(animated: true, completion: nil)
 В вашем основном контроллере реализуйте метод делегата для обновления данных:
 swift
 Copy code
 extension MainViewController: PillsViewControllerDelegate {
     func pillsViewController(_ controller: PillsViewController, didUpdatePills pills: [Pill]) {
         // Обновите данные в основном контроллере и перезагрузите таблицу
         self.pillsArray = pills
         self.tableView.reloadData()
     }
 }
 Установите основной контроллер в качестве делегата при открытии PillsViewController:
 swift
 Copy code
 // В методе didSelectRowAt
 let pillsViewController = PillsViewController()
 pillsViewController.delegate = self
 // Остальной код...
 Таким образом, при удалении данных из PillsViewController, делегат будет уведомлен, и основной контроллер обновит свои данные и перезагрузит таблицу.
 */
