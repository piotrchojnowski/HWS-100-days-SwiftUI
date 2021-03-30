//
//  ContentView.swift
//  Moonshot
//
//  Created by Piotr Chojnowski on 29/03/2021.
//

import SwiftUI

struct ImageResizableContentView: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Image("big_lake")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geo.size.width)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 8)
            }
        }
    }
}

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("CustomText initialized")
        self.text = text
    }
}

struct ScrollViewContentView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 8) {
                // Scrollview will instantiate 100 items at once.
                // to use lazy loading of cells that are visible use List() { }
                ForEach(0..<100) {
                    CustomText("#\($0)")
                        .font(.title)
                }
            }
            .frame(maxWidth: .infinity)
        }
        
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            List(0..<100) { (row) in
                NavigationLink(destination: Text("Detail \(row)")) {
                    Text("Row \(row)")
                }
            }
            .navigationBarTitle("NavigationLink + List")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
