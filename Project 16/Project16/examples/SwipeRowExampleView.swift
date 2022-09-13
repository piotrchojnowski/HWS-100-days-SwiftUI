//
//  SwipeRowExampleView.swift
//  Project16
//
//  Created by Piotr Chojnowski on 13/09/2022.
//

import SwiftUI

struct SwipeRowExampleView: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button(role: .destructive) {
                        print("Deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Pinning")
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.pink)

                }
        }
    }
}

struct SwipeRowExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SwipeRowExampleView()
    }
}
