//
//  Persistence.swift
//  ChallengeEon
//
//  Created by Rafael Ramos on 16/05/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
    
    func createCategorie(categories : Categorie, completion: @escaping() -> Void) {
        let context = container.viewContext
        let categoriesCD = CategoriesDB(context: context)
        categoriesCD.idCategory = categories.idCategory
        categoriesCD.strCategory = categories.strCategory
        categoriesCD.strCategoryDescription = categories.strCategoryDescription
        categoriesCD.strCategoryThumb = categories.strCategoryThumb
        
        do {
            try context.save()
            print("guardado")
            completion()
        } catch {
          print("Error guardando")
        }
    }
    
    func getCategoriesCoreData() -> [CategoriesDB] {
        
        let fetchRequest : NSFetchRequest<CategoriesDB> = CategoriesDB.fetchRequest()
        do {
            
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print("El error obteniendo usuario(s) \(error)")
        }
        return []
    }

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ChallengeEon")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
