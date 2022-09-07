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
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
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
                    showingImagePicker = true
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
                    
                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("InstaFilter")
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }

        image = Image(uiImage: inputImage)
    }
    
    func save() {
        
    }
}

struct InstaFilterContentView_Previews: PreviewProvider {
    static var previews: some View {
        InstaFilterContentView()
    }
}
