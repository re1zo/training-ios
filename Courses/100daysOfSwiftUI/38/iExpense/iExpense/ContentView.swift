import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items: [ExpenseItem] = [] {
        didSet {
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }

    private let encoder = JSONEncoder()

    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                            Button(action: {}, label: {
                                Image(systemName: "delete")
                            })
                        }

                        Spacer()
                        Text("$\(item.amount)")
                    }
                }.onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                HStack {
                    EditButton().padding()
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
                })
        }.sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
