//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Piotr Chojnowski on 24/01/2021.
//

import SwiftUI

struct ModifiersContentView: View {
    var body: some View {
        
        VStack() {
            Text("Welcome")
                .font(.title)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.orange)
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
            
            Button("Hello World") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 200) // order of modifier is relevant: https://www.hackingwithswift.com/books/ios-swiftui/why-modifier-order-matters
            .background(Color.red)
            
            // example of taking advantage of view modifiers:
            Text("Hello World")
                .padding()
                .background(Color.red)
                .padding()
                .background(Color.blue)
                .padding()
                .background(Color.green)
                .padding()
                .background(Color.yellow)
        }
        
    }
}

struct ContentView: View {
    
    @State private var useRedText = false
    
    var body: some View {
        Button("Hello you!") {
            self.useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
