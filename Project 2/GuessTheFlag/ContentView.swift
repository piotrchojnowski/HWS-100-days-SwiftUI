//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Piotr Chojnowski on 23/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .center, spacing: 10) {
                Text("Placeholder 1")
                Spacer()
                Text("Placeholder 2")
                Spacer()
                Text("Placeholder 3")
            }
            HStack(alignment: .center, spacing: 10) {
                Text("Placeholder 1 - super long label")
                Text("Placeholder 2")
                Text("Placeholder 3")
            }
            ZStack() {
                Color.red
                Text(" -      - ")
                    .background(Color.blue)
                    .cornerRadius(10)
                Text("Top")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
