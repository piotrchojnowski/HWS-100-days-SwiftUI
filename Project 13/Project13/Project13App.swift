//
//  Project13App.swift
//  Project13
//
//  Created by Piotr Chojnowski on 07/09/2022.
//

import SwiftUI

@main
struct Project13App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            InstaFilterContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
