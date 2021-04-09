//
//  ContentView.swift
//  Bookworm
//
//  Created by Piotr Chojnowski on 09/04/2021.
//

import SwiftUI
import CoreData

struct BindingAndSizeClassContentView: View {
    @Environment(\.horizontalSizeClass) var sizeClass

    @State private var rememberMe = false

    var body: some View {
        
        if sizeClass == .compact {
            return AnyView(VStack {
                PushButton(title: "remember me", isOn: $rememberMe)
                Text(rememberMe ? "On" : "Off")
            })
        } else {
            return AnyView(HStack {
                PushButton(title: "remember me", isOn: $rememberMe)
                Text(rememberMe ? "On" : "Off")
            })
        }
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc

    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(students, id: \.id) { student in
                    Text("Name: \(student.name ?? "unknown") \nid: \(String(student.id?.uuidString.suffix(6) ?? ["-"]))")
                }
            }
            .toolbar {
                HStack {
                    #if os(iOS)
                    EditButton()
                    #endif

                    Button(action: addStudent) {
                        Label("Add student", systemImage: "plus")
                    }
                }
                
            }
        }
        
        
        
    }
    
    func addStudent() {
        let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
        let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]

        let chosenFirstName = firstNames.randomElement()!
        let chosenLastName = lastNames.randomElement()!
        
        let student = Student(context: self.moc)
        student.id = UUID()
        student.name = "\(chosenFirstName) \(chosenLastName)"
        
        try? self.moc.save()
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
        ContentView()//.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
