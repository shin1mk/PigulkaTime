//
//  CoreDataManager.swift
//  PigulkaTime
//
//  Created by SHIN MIKHAIL on 18.11.2023.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()

    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pigulka")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func savePillToCoreData(name: String,
                             selectedDosage: String,
                             selectedType: String,
                             selectedFrequency: String,
                             selectedDays: Int,
                             selectedTimes: String?,
                             selectedTime: String) {
        let context = persistentContainer.viewContext

        let newPill = Pigulka(context: context)
        newPill.name = name
        newPill.dosage = selectedDosage
        newPill.type = selectedType
        newPill.frequency = selectedFrequency
        newPill.days = "\(selectedDays) days left"
        newPill.times = "Times \(selectedTimes ?? "empty")"
        newPill.isEditable = true
        newPill.time = "Time: \(selectedTime)"

        do {
            try context.save()
            print("Pill saved to Core Data.")
        } catch {
            print("Error saving pill to Core Data: \(error)")
        }
    }


    func loadPillsFromCoreData() -> [Pigulka] { // Change return type to [Pigulka]
           let context = persistentContainer.viewContext
           var pills: [Pigulka] = []

        let fetchRequest: NSFetchRequest<Pigulka> = NSFetchRequest<Pigulka>(entityName: "Pigulka")

           do {
               pills = try context.fetch(fetchRequest)
               print("Loaded \(pills.count) pills from Core Data.")
           } catch {
               print("Error fetching pills from Core Data: \(error)")
           }

           return pills
       }
}
