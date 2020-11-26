//
//  ContentView.swift
//  BetterRest
//
//  Created by Marcin Marynowski on 30/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()

    var body: some View {
        Form {
            DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
