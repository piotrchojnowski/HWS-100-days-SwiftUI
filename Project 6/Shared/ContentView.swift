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
struct AnimationsContentView: View {
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

struct ExplicitAnimationsContentView: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        
        Button("Hello") {
            withAnimation(.interpolatingSpring(stiffness: 10, damping: 2)) {
                animationAmount += 360
            }
        }
        .padding(40)
        .foregroundColor(.white)
        .background(Color.blue)
        .clipShape(Circle())
        .rotation3DEffect(
            .degrees(animationAmount),
            axis: (x: 0.0, y: 1.0, z: 0.0))
        
    }
}

struct CombinedAnimationsContentView: View {
    @State private var enabled = false
    
    var body: some View {
        
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.yellow)
        .foregroundColor(.white)
        .animation(/*@START_MENU_TOKEN@*/.easeIn/*@END_MENU_TOKEN@*/)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

struct AnimatingGesturesContentView: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        
        LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]), startPoint: .top, endPoint: .bottom)
            .frame(width: 280, height: 200, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in self.dragAmount = .zero }
            )
    }
}

struct SnakeAnimationContentView: View {
    let letters = Array("Hello GAYS!")
       @State private var enabled = false
       @State private var dragAmount = CGSize.zero

       var body: some View {
           HStack(spacing: 0) {
               ForEach(0..<letters.count) { num in
                   Text(String(self.letters[num]))
                       .padding(6)
                       .font(.title)
                       .background(self.enabled ? Color.red : Color.blue)
                       .offset(self.dragAmount)
                       .animation(Animation.default.delay(Double(num) / 10))
               }
           }
           .gesture(
               DragGesture()
                   .onChanged { self.dragAmount = $0.translation }
                   .onEnded { _ in
                       self.dragAmount = .zero
                       self.enabled.toggle()
                   }
           )
       }
   }

struct ContentView: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    self.isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .opacity))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
