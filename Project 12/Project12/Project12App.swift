//
//  Project12App.swift
//  Project12
//
//  Created by Piotr Chojnowski on 10/04/2021.
//

import SwiftUI

@main
struct Project12App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
