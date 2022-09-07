//
//  InstaFilterContentView.swift
//  Project13
//
//  Created by Piotr Chojnowski on 07/09/2022.
//

import SwiftUI

struct InstaFilterContentView: View {
    
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    //select image
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }
                .padding(.vertical)
                
                HStack {
                    Button("Change filter") {
                        // change filter
                    }
                    
                    Spacer()
                    
                    Button("Save") {
                        // savethe picture
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
        }
    }
}

struct InstaFilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        InstaFilterContentView()
    }
}
