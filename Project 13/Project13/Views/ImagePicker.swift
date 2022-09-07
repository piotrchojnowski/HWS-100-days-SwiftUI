//
//  ImagePicker.swift
//  Project13
//
//  Created by Piotr Chojnowski on 07/09/2022.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    
    class Coordindator: NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else {
                return
            }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    typealias UIViewControllerType = PHPickerViewController
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        //NOP
    }

    func makeCoordinator() -> Coordindator {
        Coordindator(self)
    }
}
