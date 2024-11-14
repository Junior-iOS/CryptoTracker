enum GameType: Int {
    case quina = 0
    case megasena = 1
    case timemania = 2
    case lotofacil = 3
    case lotomania = 4
    
    var title: String {
        switch self {
        case .quina: return "Quina"
        case .megasena: return "Mega-Sena"
        case .timemania: return "Timemania"
        case .lotofacil: return "Loto Fácil"
        case .lotomania: return "Lotomania"
        }
    }
    
    var color: UIColor {
        switch self {
        case .quina: return .systemGreen
        case .megasena: return .systemBlue
        case .timemania: return .systemOrange
        case .lotofacil: return .systemPurple
        case .lotomania: return .systemRed
        }
    }
} 