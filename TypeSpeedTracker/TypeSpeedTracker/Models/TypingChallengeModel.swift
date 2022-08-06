import Foundation
import CoreData

class TypingChallengeModel : BaseModel {
    var start_datetime: NSDate
    var quote: String = "";
    var author: String = ""
    var completed = false;
    var quote_generator: QuoteGenerator = QuoteGenerator();
    
    // Optionally quotes and authors can be passed in instead of random generation
    init(passed_quote:String = "", passed_author:String = "") {
        if (passed_quote != "") {
            self.quote = passed_quote
            self.author = passed_author
        } else {
            let quoteObj = quote_generator.generateQuote();
            self.quote = quoteObj.text;
            self.author = quoteObj.author
        }


        self.start_datetime = NSDate();
        super.init()
    }
    
    func saveModelToCoreData(end_datetime: NSDate, wpm: Double) {
        let challenge = TypeChallenge(context: container.viewContext)
        challenge.start_datetime = start_datetime as Date
        challenge.quote = quote
        challenge.author = author
        challenge.wpm = wpm
        challenge.end_datetime = end_datetime as Date
        self.saveCoreData()
    }
    
    func startGame() {
        self.start_datetime = NSDate();
    }
}
