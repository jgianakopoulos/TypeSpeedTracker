import Foundation
import CoreData

class TypingChallengeViewModel : ObservableObject, Identifiable {
    @Published var currentTextFieldValue : String = "" {
        didSet {
            updateForNewInput();
        }
    }
        
    @Published var game_state: String = "Ready";
    
    var remainingInput = ""
    var correctInput = ""
    var incorrectInput = ""
    var wordsPerMinute: Double = 0.0
    var displayWPM: String = "-"
    var inputTaken: Bool = false
    
    var id = UUID();
    
    private var game_model : TypingChallengeModel;
    
    init() {
        self.game_model = TypingChallengeModel()
        self.remainingInput = game_model.quote
    }
    
    func retryWithSameQuote() {
        self.game_model = TypingChallengeModel(passed_quote:game_model.quote, passed_author:game_model.author);
        self.subCreateNewGame()
    }
    
    func createNewGame() {
        self.game_model = TypingChallengeModel()
        self.subCreateNewGame()
    }
    
    func subCreateNewGame() {
        self.game_state = "Ready"
        self.remainingInput = game_model.quote
        self.incorrectInput = ""
        self.correctInput = ""
        self.wordsPerMinute = 0
        self.displayWPM = "-"
        self.currentTextFieldValue = ""
        self.inputTaken = false
    }
    
    func startGame() {
        self.remainingInput = game_model.quote
        self.incorrectInput = ""
        self.correctInput = ""
        self.game_state = "In Progress"
    }
    
    func updateForNewInput() {
        if (!inputTaken && currentTextFieldValue != "") {
            game_model.startGame()
            inputTaken = true;
        }
        
        var tempRI = ""
        var tempII = ""
        var tempCI = ""
                        
        // Iterate over quote string
        
        if (self.currentTextFieldValue.count > 0) {
            if (game_model.quote.count > self.currentTextFieldValue.count) {
                tempRI = String(game_model.quote.suffix(game_model.quote.count - self.currentTextFieldValue.count))
            }
            
            var incorrect_input = false;
            for i in 0...(self.currentTextFieldValue.count - 1) {
                if (i < game_model.quote.count) {
                    // Check if incorrect
                    
                    if (incorrect_input || game_model.quote[i] != self.currentTextFieldValue[i]) {
                        incorrect_input = true;
                        
                        if (game_model.quote[i] == " ") {
                            tempII.append(String(self.currentTextFieldValue[i]))
                        } else {
                            tempII.append(String(game_model.quote[i]))
                        }
                    } else {
                        tempCI.append(String(self.currentTextFieldValue[i]))
                    }
                } else {
                    // If the input is longer than the quote, mark remaining as incorrect
                    tempII.append(String(self.currentTextFieldValue.suffix(self.currentTextFieldValue.count - i)))
                    break
                }
            }
            
        } else {
            tempRI = game_model.quote
        }

        self.remainingInput = tempRI
        self.correctInput = tempCI
        self.incorrectInput = tempII
        self.updateWPM()
        
        if (self.currentTextFieldValue == game_model.quote && self.game_state != "Completed") {
            self.finishGame()
        }
    }
    
    func finishGame() {
        self.game_state = "Completed"
        game_model.saveModelToCoreData(end_datetime: NSDate(), wpm: self.wordsPerMinute)
    }

    var start : NSDate? {
        return game_model.start_datetime;
    }

    func updateWPM() {
        self.wordsPerMinute = self.roundToTenths((Double(self.correctInput.count / 5) / abs(game_model.start_datetime.timeIntervalSinceNow)) * 60)
        self.displayWPM = String(self.wordsPerMinute)
    }
    
    func roundToTenths(_ number : Double) -> Double {
        return round(number * 10) / 10
    }
    
    func getAuthor() -> String {
        return (game_model.author == "") ? "Unknown Author" : game_model.author
    }
}




