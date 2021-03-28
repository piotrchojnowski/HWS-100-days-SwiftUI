//
//  ContentView.swift
//  iExpenses
//
//  Created by Piotr Chojnowski on 16/03/2021.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    
    enum ExpenseType: CaseIterable, Identifiable, Codable {
        
        enum CodingKeys: CodingKey {
            case personal
            case business
        }
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let key = container.allKeys.first
            
            switch key {
            case .personal:
                self = .personal
            case .business:
                self = .business
            default:
                self = .personal
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case .personal:
                try container.encode(true, forKey: .personal)
            case .business:
                try container.encode(true, forKey: .business)
            }
        }
        
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
        
        var imageName: String {
            switch self {
            case .personal:
                return "star.fill"
            case .business:
                return "briefcase.fill"
            }
        }
    }
    
    var id = UUID()
    let name: String
    let type: ExpenseType
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            
            guard let encoded = try? encoder.encode(items) else {
                return
            }
            
            UserDefaults.standard.setValue(encoded, forKey: "Items")
        }
    }
    
    init() {
        guard let data = UserDefaults.standard.data(forKey: "Items") else {
            items = []
            return
        }
        
        let decoder = JSONDecoder()
        let decodedItems = try? decoder.decode([ExpenseItem].self, from: data)
        
        self.items = decodedItems ?? []
    }
}

struct SpendingModifier: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(6)
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(6)
    }
}

extension View {
    func spendingStyle(color: Color) -> some View {
        self.modifier(SpendingModifier(color: color))
    }
}

struct ContentView: View {
    @ObservedObject private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List() {
                if expenses.items.isEmpty {
                    ZStack {
                        Color.blue
                            .cornerRadius(16)
                        
                        VStack(spacing: -20) {
                            Image(systemName: "folder.badge.plus")
                                .foregroundColor(.white)
                                .font(.system(size: 72))
                                .padding(24)
                            
                            Text("You have no expenses, try add one.")
                                .padding(20)
                                .foregroundColor(.white)
                                .font(.title)
                        }
                        
                    }
                    
                } else {
                    ForEach(expenses.items) { item in
                        HStack {
                            HStack(spacing: 8) {
                                Image(systemName: item.type.imageName)
                                    .resizable()
                                    .foregroundColor(.blue)
                                    .frame(width: 24, height: 24, alignment: .center)
                                
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type.description)
                                        .font(.caption)
                                }
                            }
                            
                            Spacer()
                            
                            Text("\(item.amount, specifier: "%.2f")")
                                .spendingStyle(color: expenseColor(for: item.amount))
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationBarTitle("My expenses")
            .navigationBarItems(leading:
                                    HStack {
                                        if !expenses.items.isEmpty {
                                            EditButton()
                                        }
                                    }
                
                                , trailing:
                                    HStack {
                                        Button(action: {
                                            showingAddExpense = true
                                        }, label: {
                                            Image(systemName: "plus")
                                        })
                                    }
            )
                                    
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    private func expenseColor(for amount: Double) -> Color {
        switch amount {
        case 0...100:
            return Color(UIColor.systemGreen)
        case 101...1000:
            return Color(UIColor.systemIndigo)
        case 1001...:
            return Color(UIColor.systemRed)
        default:
            return Color(UIColor.systemGray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
