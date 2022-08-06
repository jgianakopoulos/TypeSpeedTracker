import SwiftUI

struct ContentView: View {
    @StateObject var viewRouter = ViewRouter()
    var body: some View {
        HStack {
            Sidebar().environmentObject(viewRouter)
            VStack {
                switch viewRouter.currentPage {
                case .typingchallenge:
                    TypingChallengeView(view_model: TypingChallengeViewModel()).padding()
                case .pastgameslist:
                    PastGamesListView()
                case .pastgamesgraph:
                    PastGamesGraphView()
                }
            }.frame(minWidth:800, maxWidth: .infinity, minHeight: 600, maxHeight: .infinity)
                .background(Color.systemsBackground.opacity(0.9))
        }
    }
}
