// Make it easier to get characters from a string using their index
extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

// An enum of all valid app Pages
enum Page {
    case typingchallenge
    case pastgameslist
    case pastgamesgraph
}
