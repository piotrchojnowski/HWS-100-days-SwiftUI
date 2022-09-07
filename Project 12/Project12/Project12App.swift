//
//  Project12App.swift
//  Project12
//
//  Created by Piotr Chojnowski on 10/04/2021.
//

import SwiftUI
import CoreData

@main
struct Project12App: App {
    let persistenceController = PersistenceController.shared

    private var moc: NSManagedObjectContext {
        let moc = persistenceController.container.viewContext
        moc.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return moc
    }
    
    var body: some Scene {
        WindowGroup {
            CandyBarsView()
                .environment(\.managedObjectContext, moc)
        }
    }
}
