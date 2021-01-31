//
//  ContentView.swift
//  WeSplit
//
//  Created by Piotr Chojnowski on 22/01/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }
    
    private var totalAmountWithTip: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentages[tipPercentage])
        let tipValue = orderAmount / 100 * tipSelection
        
        return orderAmount + tipValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<10) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .textCase(nil)
                
                Section(header: Text("Total per person:")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                .textCase(nil)
                
                Section(header: Text("Total amount:")
                            .foregroundColor(tipPercentages[tipPercentage] == 0 ? Color.red : Color.black)) {
                    Text("$\(totalAmountWithTip, specifier: "%.2f")")
                }
                .textCase(nil)
            }
            .navigationBarTitle("Split the check")
        }
        
    }
}

struct TestContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
