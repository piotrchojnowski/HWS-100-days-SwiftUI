//
//  ContentView.swift
//  Bookworm
//
//  Created by Piotr Chojnowski on 09/04/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            Text("Count: \(books.count)")
                .navigationBarTitle("Bookworm")
                .navigationBarItems(trailing:
                                        Button(action: {
                                            showingAddScreen.toggle()
                                        }, label: {
                                            Image(systemName: "plus")
                                        })
                )
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                        .environment(\.managedObjectContext, moc)
                }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}