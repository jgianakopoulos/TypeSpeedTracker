import Foundation
import CoreData

class BaseModel {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TypeSpeedTracker")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            }
        }
    }
    
    func saveCoreData() {
        do {
            try container.viewContext.save();
        } catch let error {
            print("Error saving: \(error)")
        }
    }

}
