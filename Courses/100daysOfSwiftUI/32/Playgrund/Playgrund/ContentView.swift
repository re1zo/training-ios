//
//  ContentView.swift
//  Playgrund
//
//  Created by Marcin Marynowski on 27/03/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NetworkManager().printDebugData()
        ThrottledNetworkManager().printDebugData()
        return Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
