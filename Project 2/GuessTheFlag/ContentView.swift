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

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .renderingMode(.original)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 4))
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var scoreTotal = 0
    @State private var rotationAngle = Double(0)
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTotal += 10
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(scoreTotal)"
            
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That's a flag of \(countries[number])!"
            scoreTotal -= 5
            
            if scoreTotal < 0 {
                scoreTotal = 0
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        rotationAngle = 0
    }
    
    private func isCorrectFlag(number: Int) -> Bool {
        return number == correctAnswer
    }
    
    private func buttonSelected(number: Int) {
        flagTapped(number)
        
        guard isCorrectFlag(number: number) else {
            return
        }
        
        withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
            rotationAngle += 360
        }
    }
    
    var body: some View {
        ZStack() {
            Color.secondary.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack() {
                    Text("Select flag of a country:")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.yellow)
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        
                        flagTapped(number)
                        
                        guard isCorrectFlag(number: number) else {
                            return
                        }
                        
                        withAnimation(
                            Animation.interpolatingSpring(stiffness: 10, damping: 2)
                                .repeatForever()) {
                            rotationAngle += 360
                        }
                        
                    }) {
                        FlagImage(imageName: self.countries[number])
                    }
                    .shadow(radius: 8)
                    .rotation3DEffect(
                        .degrees(rotationAngle),
                        axis: (x: 0.0, y: isCorrectFlag(number: number) ? 1.0 : 0.0, z: 0.0),
                        anchor: .center,
                        anchorZ: 0.0,
                        perspective: 1.0
                    )
                }
                
                Spacer()
                
                Text("Your score is: \(scoreTotal)")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text(scoreMessage),
                  dismissButton:
                    .default(Text("Continue")) {
                        self.askQuestion()
                    })
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
