//
//  ContentView.swift
//  BetterRestHWS
//
//  Created by Piotr Chojnowski on 02/02/2021.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var hours: Double = 8
    @State private var selectedDate: Date = Date()
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var recommendedBedtime: String {
        calculateBedtime()
        
        return alertMessage
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?")
                            .font(.headline)) {

                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                        .onChange(of: wakeUp) { _ in
                            calculateBedtime()
                        }
                }
                .textCase(.none)
                
                Section(header: Text("Desired amount of sleep")
                            .font(.headline)
                            .padding(.bottom, 8)) {
                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                    }
                    .onChange(of: sleepAmount) { _ in
                        calculateBedtime()
                    }
                }
                .textCase(.none)
                
                Section(header: Text("Daily coffee intake")
                            .font(.headline)
                            .padding(.bottom, 8)) {
//                    Stepper(value: $coffeeAmount, in: 1...10) {
//                        if coffeeAmount == 1 {
//                            Text("1 cup")
//                        } else {
//                            Text("\(coffeeAmount+1) cups")
//                        }
//                    }
                    
                    //implemented challenge #2, but I preffer stepper.
                    Picker("cups", selection: $coffeeAmount) {
                        ForEach(1..<11, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                .textCase(.none)
                
                Section(header: Text("Bed time")
                            .font(.largeTitle)) {
                    
                    HStack {
                        Image(systemName: "clock.fill")
                            .foregroundColor(Color(UIColor.systemGray))
                        Text(alertMessage)
                    }
                    
                }
                .textCase(.none)
            }
            .navigationBarTitle("BetterRest")
            .onAppear() {
                calculateBedtime()
            }
        }
    }
    
    private func calculateBedtime() {
        do {
            let model = try SleepCalculatorModel(configuration: MLModelConfiguration())
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount+1))

            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short

            alertMessage = formatter.string(from: sleepTime)
            alertTitle = "Your ideal bedtime is..."
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
