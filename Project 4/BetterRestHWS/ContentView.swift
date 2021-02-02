//
//  ContentView.swift
//  BetterRestHWS
//
//  Created by Piotr Chojnowski on 02/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var hours: Double = 8
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
            Stepper(value: $hours, in: 4...20, step: 0.25) {
                Text("\(hours, specifier: "%g")")
                    .padding()
            }
            .padding()
            
            Form {
                DatePicker("Select date", selection: $selectedDate, in: Date()..., displayedComponents: .hourAndMinute)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
