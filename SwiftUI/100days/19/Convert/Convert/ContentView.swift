import SwiftUI

struct ContentView: View {

    @State private var value = "0"
    @State private var selectedUnit = TemphUnits.celsius
    
    private var unitsToConvert: [TemphUnits] {
        TemphUnits.allCases.filter { $0 != selectedUnit }
    }

    private func convert(to temph: TemphUnits) -> Double {
        let number = Double(value) ?? 0
    
        switch selectedUnit {
        case .celsius:
            return temph == .kelvin ? number + 273 : (number * 1.8) + 32
        case .kelvin:
            return temph == .celsius ? number - 273 : ((number * 9) / 5) - 459.67
        case .fahrenheit:
            return temph == .celsius ? number / 1.8 : (number * 5) / 9
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select unit:", selection: $selectedUnit) {
                        ForEach(0 ..< TemphUnits.allCases.count) {
                            Text("\(TemphUnits.allCases[$0].rawValue.capitalized)").tag(TemphUnits.allCases[$0])
                        }
                    }
                    
                    TextField("Value: ", text: $value)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Text("Selected: \(value) \(selectedUnit.rawValue.capitalized)")
                }
                
                Section {
                    ForEach(0 ..< unitsToConvert.count) {
                        Text("\(convert(to: unitsToConvert[$0])) \(unitsToConvert[$0].symbol)")
                    }
                }
            }.navigationTitle("ConvertTemp")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
