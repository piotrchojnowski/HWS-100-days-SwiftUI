//
//  ContentView.swift
//  iExpenses
//
//  Created by Piotr Chojnowski on 16/03/2021.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ContentView: View {
    @ObservedObject private var user = User()
    
    var body: some View {
        VStack {
            Text("your name is \(user.firstName) lastname: \(user.lastName)")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
