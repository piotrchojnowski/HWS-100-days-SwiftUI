//
//  ContentView.swift
//  Shared
//
//  Created by Piotr Chojnowski on 05/03/2021.
//

import SwiftUI

struct FirstAnimationContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        Button("Hello") {
//            animationAmount += 1
        }
        .padding(50)
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.black, lineWidth: 1)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .animation(
                    Animation.easeIn(duration: 0.8)
                        .repeatForever(autoreverses: false)
                )
        )
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount - 1) * 2)
        .onAppear {
            self.animationAmount = 2
        }
    }
}

struct ContentView: View {
    @State private var animationAmount: CGFloat = 1
    
    var body: some View {
        
        VStack {
            Stepper("animation value",
                    value: $animationAmount.animation(
                        Animation
                            .easeOut(duration: 1)
                            .repeatCount(3, autoreverses: true)
                    ),
                    in: 1...10)
            
            Spacer()
            
            Button("Hello") {
                animationAmount += 1
            }
            .padding(40)
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Circle())
            .scaleEffect(animationAmount)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
