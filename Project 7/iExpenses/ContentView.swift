//
//  ContentView.swift
//  iExpenses
//
//  Created by Piotr Chojnowski on 16/03/2021.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    enum ExpenseType: CaseIterable, Identifiable {
        case personal
        case business
        
        var description: String {
            switch self {
            case .personal:
                return "Personal"
            case .business:
                return "Business"
            }
        }
        
        var id: String {
            return description
        }
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
    @State private var showingAddExpense = false
    
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
                                        showingAddExpense = true
                                    }, label: {
                                        Image(systemName: "plus")
                                    }))
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
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
