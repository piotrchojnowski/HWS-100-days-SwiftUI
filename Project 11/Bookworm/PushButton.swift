//
//  PushButton.swift
//  Bookworm
//
//  Created by Piotr Chojnowski on 09/04/2021.
//

import SwiftUI

struct PushButton: View {
    let title: String
    @Binding var isOn: Bool
    
    var onColors = [Color.blue, Color.green]
    var offColors = [Color(white: 0.6), Color(white: 0.4)]
    
    var body: some View {
        Button("Button") {
            isOn.toggle()
        }
        .padding(.vertical)
        .padding(.horizontal, 40)
        .background(LinearGradient(gradient: Gradient(colors: isOn ? onColors : offColors), startPoint: .top, endPoint: .bottom))
        .foregroundColor(.white)
        .font(.title2)
        .clipShape(Capsule())
        .shadow(radius: isOn ? 0 : 5)
    }
}

struct PushButton_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State(initialValue: false) var isOn: Bool
        
        var body: some View {
            PushButton(title: "Hello world", isOn: $isOn)
        }
    }
}
