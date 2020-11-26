enum TemphUnits: String, CaseIterable {
    case celsius
    case fahrenheit
    case kelvin

    var symbol: String {
        switch self {
        case .celsius:
            return "°C"
        case .fahrenheit:
            return "°F"
        case .kelvin:
            return "°K"
        }
    }
}
