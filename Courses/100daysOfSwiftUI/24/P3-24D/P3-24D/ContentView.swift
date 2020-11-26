//
//  ContentView.swift
//  P3-24D
//
//  Created by Marcin Marynowski on 26/11/2020.
//

import SwiftUI

struct LargeTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(Color.blue)
    }
}

extension View {
    func largeTitle() -> some View {
        modifier(LargeTitle())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!").largeTitle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
