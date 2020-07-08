//
//  ContentView.swift
//  WeSplit
//
//  Created by Marcin Marynowski on 10/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    private let students = ["Harry", "Hermione", "Ron"]
    @State private var selectedStudent = "Harry"
        
        var body: some View {
            Picker("Select your student.", selection: $selectedStudent) {
                ForEach(0 ..< students.count) {
                    Text(self.students[$0])
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
