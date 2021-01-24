//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Piotr Chojnowski on 23/01/2021.
//

import SwiftUI

struct StacksContentView: View {
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
                    .frame(width: 100, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                    .cornerRadius(8)
                Text(" -      - ")
                    .background(Color.blue)
                    .cornerRadius(10)
                Text("Top")
            }
            
        }
    }
}

struct GradientContentView: View {
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
                    .frame(width: 100, height: 100, alignment: .center)
                    .cornerRadius(8)
                Text(" -      - ")
                    .background(Color.blue)
                    .cornerRadius(10)
                Text("Top")
            }
            
        }
    }
}

struct GradientsContentView: View {
    var body: some View {
        VStack() {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.secondary]), startPoint: UnitPoint(x: 0.5, y: 0.1), endPoint: .bottom)
            
            Spacer()
            
            RadialGradient(gradient: Gradient(colors: [Color.purple, Color.white]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startRadius: 10, endRadius: 200)
            
            Spacer()
            
            AngularGradient(gradient: Gradient(colors: [Color.blue, Color.white, .blue]), center: .center)
        }
    }
}

struct ButtonsContentView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Button("Tap me!") {
                print("Button was tapped!")
            }

            Button(action: {
                print("button with image tapped!")
            }, label: {
                HStack() {
                    Image(systemName: "pencil")
                        .renderingMode(.original)
                    Text("Edit")
                        .fontWeight(.medium)
                }
                
            })
        }
    }
}

struct AlertContentView: View {
    @State private var isAlertPresented = false
    
    var body: some View {
        
        Button("Tap me!") {
            self.isAlertPresented = true
        }
        .alert(isPresented: $isAlertPresented) {
            Alert(title: Text("Alert SwiftUI"), message: Text("Showing alert."), dismissButton: .default(Text("dismiss")))
        }
        
    }
}

struct ContentView: View {
    @State private var isAlertPresented = false
    
    var body: some View {
        Text("Hello")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
