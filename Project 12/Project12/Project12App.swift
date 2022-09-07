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
        moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return moc
    }
    
    var body: some Scene {
        WindowGroup {
            SingerView()
                .environment(\.managedObjectContext, moc)
        }
    }
}
