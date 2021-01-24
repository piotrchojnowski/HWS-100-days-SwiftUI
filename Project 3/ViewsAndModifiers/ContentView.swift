//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Piotr Chojnowski on 24/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Welcome")
            .font(.title)
            .fontWeight(.bold)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.orange)
            .foregroundColor(.white)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
