//
//  TabsExampleView.swift
//  Project16
//
//  Created by Piotr Chojnowski on 12/09/2022.
//

import SwiftUI

struct TabsExampleView: View {
    
    @State private var selectedTab = "One"
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "Three"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }
                .tag("One")
            Text("Tab 2")
                .tabItem {
                    Label("Two", systemImage: "circle")
                }
                .tag("Two")
            Text("Tab 3")
                .tabItem {
                    Label("Three", systemImage: "🍕")
                }
                .tag("Three")
        }
    }
}

struct TabsExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TabsExampleView()
    }
}
