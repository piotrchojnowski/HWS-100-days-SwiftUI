//
//  BackgroundExampleView.swift
//  Project17
//
//  Created by Piotr Chojnowski on 20/09/2022.
//

import SwiftUI

struct BackgroundExampleView: View {
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        Text("Hello, world!")
            .padding()
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {
                    print("Active")
                } else if newPhase == .inactive {
                    print("Inactive")
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

struct BackgroundExampleView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundExampleView()
    }
}
