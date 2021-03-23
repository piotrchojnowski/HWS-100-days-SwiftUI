//
//  AddView.swift
//  iExpenses
//
//  Created by Piotr Chojnowski on 22/03/2021.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var type: ExpenseItem.ExpenseType = .personal
    @State private var amount = ""
    
    static let types = ExpenseItem.ExpenseType.allCases
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Section {
                    Picker("Type", selection: $type) {
                        ForEach(Self.types, id: \.id) {
                            Text($0.description)
                                .tag($0)
                        }
                    }
                }
                
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Double(amount) {
                    let item = ExpenseItem(name: name, type: type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
