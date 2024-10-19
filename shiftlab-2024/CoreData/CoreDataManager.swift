//
//  CoreDataManger.swift
//  shiftlab-2024
//
//  Created by Тимур Осокин on 18.10.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() { }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "shiftlab_2024")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func obtainSavedData() -> String? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        fetchRequest.fetchLimit = 1
        
        do {
            let users = try context.fetch(fetchRequest)
            
            if let user = users.first {
                return user.name
            } else {
                return nil
            }
        } catch {
            print("Ошибка выполения запроса: \(error)")
            return nil
        }
    }
    
    func deleteUser() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first {
                context.delete(user)
                saveContext()
                print("Имя пользователя удалено")
            }
            else {
                print("Пользователей не найден")
            }
        }
        catch {
            print("Ошибка при удалении пользователя: \(error)")
        }
    }
}
