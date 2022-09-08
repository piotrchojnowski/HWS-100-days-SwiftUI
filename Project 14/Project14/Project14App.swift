//
//  Project14App.swift
//  Project14
//
//  Created by Piotr Chojnowski on 08/09/2022.
//

import SwiftUI

@main
struct Project14App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            BucketListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
