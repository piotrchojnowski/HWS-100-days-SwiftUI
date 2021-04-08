//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Piotr Chojnowski on 07/04/2021.
//

import SwiftUI


struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}


struct DownloadingDataContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }
    
    func loadData() {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // we have good data – go back to the main thread
            DispatchQueue.main.async {
                // update our UI
                self.results = decodedResponse.results
            }

        }.resume()
    }
}

struct DisableContentView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var signupButtonDisabled: Bool {
        username.count < 5 || password.count < 3
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("password", text: $password)
            }
            
            Section {
                Button("Create account") {
                    print("creating account...")
                }
            }
            .disabled(signupButtonDisabled)
        }
    }

}

struct ContentView: View {

    var body: some View {
        Text("hello")
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
