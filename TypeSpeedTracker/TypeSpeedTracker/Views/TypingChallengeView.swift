import SwiftUI

struct TypingChallengeView : View {
    @ObservedObject var view_model : TypingChallengeViewModel;
    
    init(view_model : TypingChallengeViewModel) {
        self.view_model = view_model;
        view_model.createNewGame();
    }

    var body: some View {
        VStack {
            switch(view_model.game_state) {
                case "Ready":
                TypingChallengeReadyView(view_model: self.view_model)
                case "In Progress":
                TypingChallengeInProgressView(view_model: self.view_model)
                case "Completed":
                TypingChallengeCompletedView(view_model: self.view_model)
            default:
                Text("An error occurred, try going to the homepage or closing the app")
            }
        }
    }
    
}

struct TypingChallengeReadyView : View {
    @ObservedObject var view_model : TypingChallengeViewModel;

    var body: some View {
        VStack {
            VStack {
                Text(view_model.remainingInput).frame(alignment: .center).font(.system(size: 20)).padding(5)
                Text("-" + view_model.getAuthor()).italic()
            }.padding(10)

            Button(action: {
                view_model.startGame();
            }) {
                Text("Start Game")
            }
        }
    }
}

struct TypingChallengeInProgressView : View {
    @ObservedObject var view_model : TypingChallengeViewModel
    
    var body : some View {
        VStack {
            ZStack(alignment:.topTrailing) {
                Text(view_model.displayWPM + " wpm")
            }
            VStack {
                HStack(spacing: 0) {
                    Text(view_model.correctInput).foregroundColor(Color.green) + Text(view_model.incorrectInput).foregroundColor(Color.red) + Text(view_model.remainingInput).foregroundColor(Color.white)
                }.frame(alignment: .center).font(.system(size: 20)).padding(5)
                Text("-" + view_model.getAuthor()).italic()
            }.padding(10)
            TextField(view_model.remainingInput, text: $view_model.currentTextFieldValue).padding()
        }
    }
}


struct TypingChallengeCompletedView : View {
    @ObservedObject var view_model : TypingChallengeViewModel;

    var body: some View {
        VStack (spacing: 50) {
            VStack {
                Text("Your Speed was...")
                Text(view_model.displayWPM).font(.system(size:50))
                Text("WPM")
            }
            HStack (alignment: .bottom, spacing: 200) {
                VStack (spacing: 10) {
                    Button(action: {
                        view_model.retryWithSameQuote();
                    }) {
                        Image(systemName: "goforward").font(.system(size: 50))
                    }.buttonStyle(PlainButtonStyle())
                    Text("Try Again")
                }
                
                VStack (spacing: 10) {
                    Button(action: {
                        view_model.createNewGame();
                    }) {
                        Image(systemName: "forward.frame.fill").font(.system(size: 50))
                    }.buttonStyle(PlainButtonStyle())
                    Text("New Quote")
                }
            }
        }
    }
}
