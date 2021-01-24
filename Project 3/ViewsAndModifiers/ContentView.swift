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

struct ConditionalModifiersContentView: View {
    
    @State private var useRedText = false
    
    var body: some View {
        Button("Hello you!") {
            self.useRedText.toggle()
        }
        .foregroundColor(useRedText ? .red : .blue)
    }
}

/// https://www.hackingwithswift.com/books/ios-swiftui/environment-modifiers
struct EnvRegModifiersContentView: View {
    
    @State private var useRedText = false
    
    var body: some View {
        VStack {
            Text("Gryffindor")
                .font(.largeTitle)
            Text("Hufflepuff")
            Text("Ravenclaw")
            Text("Slytherin")
        }
        .font(.title) // environment modifier kind
        .blur(radius: 10) // local modifier kind
    }
}

struct PropertiesContentView: View {
    /// as a computed property as well
    var motto1: some View {
        Text("Draco dormiens")
    }
    
    let motto2 = Text("nunquam titillandus")

    var body: some View {
        VStack {
            motto1
                .foregroundColor(.green)
            motto2
        }
    }
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundColor(.yellow)
            CapsuleText(text: "Second")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
