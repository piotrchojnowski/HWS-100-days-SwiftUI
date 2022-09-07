//
//  InstafilterView.swift
//  Project13
//
//  Created by Piotr Chojnowski on 07/09/2022.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct InstafilterView: View {
    @State private var image: Image?
    @State private var intenisty: Float = 1
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Slider(value: $intenisty, in: 1...100)
                .onChange(of: intenisty) { _ in
                    loadImage()
                }
        }
        .onAppear(perform: loadImage)
    }
    
    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else {
            return
        }
        
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentFilter = CIFilter.crystallize()
        currentFilter.inputImage = beginImage
        currentFilter.radius = intenisty
        
        guard let outputImage = currentFilter.outputImage else {
            return
        }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiIamge = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiIamge)
        }
    }
}

struct InstafilterView_Previews: PreviewProvider {
    static var previews: some View {
        InstafilterView()
    }
}
