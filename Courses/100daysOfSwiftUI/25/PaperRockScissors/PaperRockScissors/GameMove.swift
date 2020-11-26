enum GameMove: String, CaseIterable {
    case paper
    case rock
    case scissors

    var iconized: String {
        switch self {
        case .paper:
            return "✋"
        case .rock:
            return "✊"
        case .scissors:
            return "✌️"
        }
    }

    func deff(from move: GameMove) -> Bool {
        switch self {
        case .paper:
            return (move == .paper || move == .rock) ? false : true
        case .rock:
            return (move == .rock || move == .scissors) ? false : true
        case .scissors:
            return (move == .scissors || move == .paper) ? false : true
        }
    }
}
