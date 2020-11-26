//
//  ContentView.swift
//  WordScramble
//
//  Created by Marcin Marynowski on 21/12/2020.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        let world = "swift"
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: world.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: world, range: range, startingAt: 0, wrap: false, language: "en")
        let allGood = misspelledRange.location == NSNotFound
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
