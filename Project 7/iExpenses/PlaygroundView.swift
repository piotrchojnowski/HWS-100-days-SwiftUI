//
//  PlaygroundView.swift
//  iExpenses
//
//  Created by Piotr Chojnowski on 21/03/2021.
//

import SwiftUI

private class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ObservedObjectContentView: View {
    @ObservedObject private var user = User()
    
    var body: some View {
        VStack {
            Text("your name is \(user.firstName) lastname: \(user.lastName)")
            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}

struct SecondContentView: View {
    @Environment(\.presentationMode) var presentationMode
    var name: String
    
    var body: some View {
        
        ZStack {
            Color.secondary.edgesIgnoringSafeArea(.all)
            
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(3.0)
        }
    }
}

struct SheetPresentingContentView: View {
    
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        Button("Push modal") {
            self.isShowingSheet.toggle()
        }
        .sheet(isPresented: $isShowingSheet) {
            SecondContentView(name: "Piotr")
        }
    }
}

struct DeletingItemsContentView: View {
    
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("#\($0)")
                    }
                    .onDelete(perform: removeItem)
                }
                
                Button("Add number") {
                    self.numbers.append(self.currentNumber)
                    currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }
    
    private func removeItem(atOffsets offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}


struct UserDefaultsContentView: View {
    private static let tapsKey = "Taps"
    @State private var tapCount: Int = UserDefaults.standard.integer(forKey: tapsKey)
    
    var body: some View {
        Button("Tap count: \(tapCount)") {
            self.tapCount += 1
            UserDefaults.standard.setValue(tapCount, forKey: UserDefaultsContentView.tapsKey)
        }
    }
}

private struct UserData: Codable {
    var firstName: String
    var lastName: String
}

struct CodableUserDefaultsContentView: View {
    
    @State private var user = UserData(firstName: "Taylor", lastName: "Swift")
    @State private var userToDisplay: UserData? = nil
        
    var body: some View {
        VStack {
            Button("Encode") {
                let encoder = JSONEncoder()
                
                guard let data = try? encoder.encode(self.user) else {
                    return
                }
                
                UserDefaults.standard.setValue(data, forKey: "UserData")
            }
            
            Button("Decode") {
                
                guard let savedUserData = UserDefaults.standard.value(forKey: "UserData") as? Data else {
                    return
                }
                
                let decoder = JSONDecoder()
                
                guard let user = try? decoder.decode(UserData.self, from: savedUserData) else {
                    return
                }
                
                self.userToDisplay = user
            }
            
            Text("User: \(userToDisplay?.firstName ?? ""), \(userToDisplay?.lastName ?? "")")
        }

    }
}


struct DeletingItemsContentView_Previews: PreviewProvider {
    static var previews: some View {
        DeletingItemsContentView()
    }
}
