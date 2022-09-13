//
//  ResultExampleView.swift
//  Project16
//
//  Created by Piotr Chojnowski on 13/09/2022.
//

import SwiftUI

struct ResultExampleView: View {

    @State private var output = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }
    
    func fetchReadings() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings."
        }

        let result = await fetchTask.result
        
//        do {
//            output = try result.get()
//        } catch {
//            print(error)
//        }
        
        switch result {
        case .success(let success):
            output = success
        case .failure(let failure):
            output = failure.localizedDescription
        }
    }
}


// Without using Result type

//struct ResultExampleView: View {
//
//    @State private var output = ""
//
//    var body: some View {
//        Text(output)
//            .task {
//                await fetchReadings()
//            }
//    }
//
//    func fetchReadings() async {
//        do {
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let readings = try JSONDecoder().decode([Double].self, from: data)
//            output = "Found \(readings.count) readings."
//        } catch {
//            print("error")
//        }
//    }
//}

struct ResultExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ResultExampleView()
    }
}
