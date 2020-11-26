import SwiftUI

struct ContentView: View {
    private let moves = GameMove.allCases
    @State private var showingAnswer = false
    @State private var move = GameMove.allCases.randomElement() ?? .paper
    @State private var score = 0
    @State private var scoreTitle = ""

    var body: some View {
        VStack(spacing: 150) {
            VStack(spacing: 10) {
                Text("Eneamy attack you with:")
                    .font(.title)
                    .padding()
                Text(move.iconized)
                    .font(.largeTitle)
                    .bold()
            }

            VStack(spacing: 15) {
                Text("Counter with:")
                HStack {
                    ForEach(0 ..< moves.count) { index in
                        Button(moves[index].iconized) {
                            play(attack: moves[index])
                        }
                        .font(.largeTitle)
                        .padding()
                    }
                }
                Text("Score: \(score)")
            }.padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
        .alert(isPresented: $showingAnswer) {
            Alert(title: Text(scoreTitle), dismissButton: .default(Text("Continue")) {})
        }
    }

    func play(attack: GameMove) {
        if move.deff(from: attack) {
            score += 1
            scoreTitle = "Correct"
        } else {
            score -= 1
            scoreTitle = "Wrong"
        }
        showingAnswer = true
        move = GameMove.allCases.randomElement() ?? .paper
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
