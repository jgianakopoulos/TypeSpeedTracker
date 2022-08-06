import Foundation
import CoreData

class PastGamesViewModel: ObservableObject {
    let container: NSPersistentContainer
    @Published var pastGames: [TypeChallenge] = []

    init() {
        container = NSPersistentContainer(name: "TypeSpeedTracker")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading core data: \(error)")
            }
        }
        
        fetchPastGames()
    }
    
    func deletePastGame(index_set: IndexSet) {
        for index in index_set {
            do {
                let game = pastGames[index]
                self.container.viewContext.delete(game)
                try self.container.viewContext.save()
            } catch let error {
                print(error)
            }
        }
        
        self.pastGames.remove(atOffsets: index_set)
    }
    
    func fetchPastGames() {
        let request = NSFetchRequest<TypeChallenge>(entityName: "TypeChallenge")
        
        do {
            self.pastGames = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching past games: \(error)")
        }
    }
    
}
