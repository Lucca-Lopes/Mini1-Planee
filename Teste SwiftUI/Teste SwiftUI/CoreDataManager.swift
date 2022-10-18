//
//  CoreDataManager.swift
//  Teste SwiftUI
//
//  Created by Lucca Lopes on 22/09/22.
//

import CoreData

class CoreDataManager {
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init() {
        container = NSPersistentContainer(name: "Teste_SwiftUI")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Erro ao carregar o Core Data. \(error)")
            }
        }
        context = container.viewContext
    }
    
    func salvar() {
        do {
            try context.save()
        } catch let error {
            print("Erro ao salvar o Core Data, \(error.localizedDescription)")
        }
    }
}
