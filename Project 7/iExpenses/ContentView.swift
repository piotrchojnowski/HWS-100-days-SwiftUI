//
//  ContentView.swift
//  iExpenses
//
//  Created by Piotr Chojnowski on 16/03/2021.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    enum ExpenseType {
        case `private`
        case business
    }
    
    let id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}

struct ContentView: View {
    @ObservedObject private var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(expenses.items) { item in
                    Text("\(item.name)")
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("My expenses")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        let expense = ExpenseItem(name: "test", type: .private, amount: 10)
                                        self.expenses.items.append(expense)
                                    }, label: {
                                        Text("add")
                                    })
            )
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
