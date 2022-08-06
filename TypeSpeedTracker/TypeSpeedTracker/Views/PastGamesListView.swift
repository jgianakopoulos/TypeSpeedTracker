import SwiftUI

struct PastGamesListView: View {
    @ObservedObject var pastGamesViewModel = PastGamesViewModel()
    
    var body: some View {
        VStack {
            Text("Past Games").font(.system(size:24))
            List {
                ForEach(pastGamesViewModel.pastGames) { pastgame in
                    HStack {
                        VStack {
                            Text(String(pastgame.wpm)).font(.system(size:16))
                            Text("WPM")
                        }
                        VStack (alignment:.leading, spacing:5) {
                            Text(pastgame.quote ?? "Error loading quote").font(.system(size:16))
                            Text(pastgame.author ?? "unknown author").italic()
                        }
                    }.padding(10)
                }.onDelete { (indexSet) in
                    pastGamesViewModel.deletePastGame(index_set: indexSet)
                }
            }
            // TODO: Uncomment the following line when this function becomes available with the next OS release (iOS 16, macOS 13). That will fix the background color issue with this list
            // .scrollContentBackground(.hidden)
        }
    }
}
