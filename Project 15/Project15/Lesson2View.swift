//
//  Lesson2View.swift
//  Project15
//
//  Created by Piotr Chojnowski on 10/09/2022.
//

import SwiftUI

//struct Lesson2View: View {
//    var body: some View {
//        Image(decorative: "character")
//            .accessibilityHidden(true)
//    }
//}

//struct Lesson2View: View {
//    var body: some View {
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
//        .accessibilityElement(children: .ignore)
//        .accessibilityLabel("Your score is 1000")
//    }
//}

struct Lesson2View: View {
    @State private var value = 10

    var body: some View {
        VStack {
            Text("Value: \(value)")

            Button("Increment") {
                value += 1
            }

            Button("Decrement") {
                value -= 1
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Value")
        .accessibilityValue(String(value))
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                value += 1
            case .decrement:
                value -= 1
            default:
                print("Not handled.")
            }
        }
    }
}

struct Lesson2View_Previews: PreviewProvider {
    static var previews: some View {
        Lesson2View()
    }
}
