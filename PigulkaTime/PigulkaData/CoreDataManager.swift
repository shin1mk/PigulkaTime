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
    //MARK: - save to core data
    func savePillToCoreData(name: String,
                            selectedDosage: String,
                            selectedType: String,
                            selectedFrequency: String,
                            selectedDays: Int,
                            selectedTimes: String?,
                            startDate: Date) {
        let context = persistentContainer.viewContext
        
        let newPill = Pigulka(context: context)
        newPill.name = name
        newPill.dosage = selectedDosage
        newPill.type = selectedType
        newPill.frequency = selectedFrequency
        newPill.days = "\(selectedDays)"
        newPill.times = selectedTimes
        newPill.isEditable = true
        newPill.uniqueIdentifier = UUID().uuidString
        newPill.startDate = Date()
        do {
            try context.save()
            print("Pill saved to Core Data.")
        } catch {
            print("Error saving pill to Core Data: \(error)")
        }
    }
    //MARK: - load from core data
    func loadPillsFromCoreData() -> [Pigulka] {
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
    //MARK: - delete from core data
    func deletePillFromCoreData(pill: Pigulka) {
        let context = persistentContainer.viewContext
        context.delete(pill)
        
        do {
            try context.save()
            print("Pill deleted from Core Data.")
        } catch {
            print("Error deleting pill from Core Data: \(error)")
        }
    }
    //MARK: - update in core data
    func updatePillInCoreData(pill: Pigulka, dosage: String, type: String, frequency: String, days: Int, times: String?) {
        let context = persistentContainer.viewContext
        // Обновляем свойства существующего объекта
        pill.dosage = dosage
        pill.type = type
        pill.frequency = frequency
        pill.days = "\(days)"
        pill.times = times
        pill.startDate = Date()
        
        do {
            try context.save()
            print("Pill updated in Core Data.")
        } catch {
            print("Error updating pill in Core Data: \(error)")
        }
    }
}
