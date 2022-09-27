//
//  SearchableExampleView.swift
//  Project19
//
//  Created by Piotr Chojnowski on 26/09/2022.
//

import SwiftUI

struct SearchableExampleView: View {
//    @State private var searchText = ""
//  simple example:
//
//    var body: some View {
//        NavigationView {
//            Text("Searching for \(searchText)")
//                .searchable(text: $searchText, prompt: "Look for something")
//                .navigationTitle("Searching")
//        }
//    }
    
    
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

    var body: some View {
        NavigationView {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }

    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct SearchableExampleView_Previews: PreviewProvider {
    static var previews: some View {
        SearchableExampleView()
    }
}
