//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Marcin Marynowski on 13/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "UK",
        "US",
        "Spain",
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Monaco",
        "Nigeria",
        "Poland",
        "Russia",
    ].shuffled()

    @State private var correctAnswer = Int.random(in: 0 ... 2)

    @State private var showingScore = false
    @State private var score = 0

    @State private var scoreTitle = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: countries[number])
                    }
                }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.black)
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
        } else {
            score = 0
            scoreTitle = "Wrong! That’s the flag of \(countries[number])"
        }
        showingScore = true
    }

    func askQuestion() {
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
