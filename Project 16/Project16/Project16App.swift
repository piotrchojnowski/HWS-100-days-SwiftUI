//
//  Project16App.swift
//  Project16
//
//  Created by Piotr Chojnowski on 10/09/2022.
//

import SwiftUI

@main
struct Project16App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
