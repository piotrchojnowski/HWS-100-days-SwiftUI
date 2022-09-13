//
//  ContextMenuExampleView.swift
//  Project16
//
//  Created by Piotr Chojnowski on 13/09/2022.
//

import SwiftUI

struct ContextMenuExampleView: View {
    
    @State private var backgroundColor = Color.red
    
    var body: some View {
        VStack {
            Text("Hello World")
                .padding()
                .background(backgroundColor)
            
            Text("Change Color")
                .padding()
                .contextMenu {
                    Button(role: .destructive) { // omnly way to get it red colored.
                        backgroundColor = .red
                    } label: {
                        Label("Red", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green) // this gets ignored
                    }

                    Button("Green") {
                        backgroundColor = .green
                    }

                    Button("Blue") {
                        backgroundColor = .blue
                    }
                }
        }
    }
}

struct ContextMenuExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenuExampleView()
    }
}
