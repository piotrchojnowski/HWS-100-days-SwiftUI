//
//  DisableExampleView.swift
//  Project17
//
//  Created by Piotr Chojnowski on 20/09/2022.
//

import SwiftUI

struct DisableExampleView: View {
    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//        }
        
        
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle()) // this makes whole VStack tappable area
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}

struct DisableExampleView_Previews: PreviewProvider {
    static var previews: some View {
        DisableExampleView()
    }
}
