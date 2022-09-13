//
//  ObservableExampleView.swift
//  Project16
//
//  Created by Piotr Chojnowski on 13/09/2022.
//

import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    
//    @Published var value = 0
    // is equivalent to:
    var value = 0 {
        willSet {
            objectWillChange.send() // manually sending message that the data has changed.
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ObservableExampleView: View {
    
    @StateObject private var updater = DelayedUpdater()
    
    var body: some View {
        Text("Value is \(updater.value)")
    }
}

struct ObservableExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableExampleView()
    }
}
