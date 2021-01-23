//
//  PlaygroundContentView.swift
//  WeSplit
//
//  Created by Piotr Chojnowski on 23/01/2021.
//

import SwiftUI

struct ListButtonItem: View {
    @State private var itemCount: Int = 0
    
    var body: some View {
        HStack {
            Text("items: \(itemCount)")
            Spacer()
            Button("(+)") {
                itemCount += 1
            }
        }
    }
}

struct StudentsPickerView: View {
    @State private var students = ["Harry", "Hermione", "Roy", "Malfloy"]
    
    var body: some View {
        Picker("Select student", selection: $students) {
            ForEach(0..<students.count) {
                Text(self.students[$0])
            }
        }
    }
}

struct TestContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("Section first item!")
                        .foregroundColor(.red)
                    Text("Time: \(Date(timeIntervalSinceNow: -60*60*2)...Date())")
                    
                    ListButtonItem()
                    StudentsPickerView()
                }
                
                Group {
                    Text("Item in a group")
                }
                
                Text("Outside the group..")
                Text("last item.")
            }
            .navigationBarTitle("My settings")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TestContentView()
        }
    }
}
