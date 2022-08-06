import Foundation

struct Quote: Decodable {
    let author: String
    let text: String
}

class QuoteGenerator {
    func generateQuote() -> Quote {
        var json: [Quote]
        let error_val = Quote(author: "Invalid Author", text:"Invalid Text")
        
        if let path = Bundle.main.path(forResource: "quotes", ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                
                let decoder = JSONDecoder()
                json = try decoder.decode([Quote].self, from: data)
                return json.randomElement() ?? error_val
            } catch {
                print(error);
            }
        }
        
        return error_val
    }
}

