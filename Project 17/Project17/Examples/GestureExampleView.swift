//
//  GestureExampleView.swift
//  Project17
//
//  Created by Piotr Chojnowski on 18/09/2022.
//

import SwiftUI

struct GestureExampleView: View {
//    var body: some View {
//        Text("Hello, World!")
//            .padding()
//            .onLongPressGesture {
//                print("long press")
//            } onPressingChanged: { state in
//                print("in progress: \(state)")
//            }
//    }
    
    //Magnification example
    
//    @State private var currentAmount = 0.0
//    @State private var finalAmount = 1.0
//
//    var body: some View {
//        Text("Hello, World!")
//            .padding()
//            .scaleEffect(finalAmount + currentAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { amount in
//                        currentAmount = amount - 1
//                    }
//                    .onEnded { amount in
//                        finalAmount += currentAmount
//                        currentAmount = 0
//                    }
//            )
//    }
    
    // Rotation example
    
//    @State private var currentAmount = Angle.zero
//    @State private var finalAmount = Angle.zero
//
//            .rotationEffect(finalAmount + currentAmount)
//            .gesture(
//                RotationGesture()
//                    .onChanged { angle in
//                        currentAmount = angle
//                    }
//                    .onEnded { angle in
//                        finalAmount += currentAmount
//                        currentAmount = .zero
//                    }
//            )
        
        
    @State private var offset = CGSize.zero
    @State private var isDragging = false
        
    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        let combined = pressGesture.sequenced(before: dragGesture)
        
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

struct GestureExampleView_Previews: PreviewProvider {
    static var previews: some View {
        GestureExampleView()
    }
}
