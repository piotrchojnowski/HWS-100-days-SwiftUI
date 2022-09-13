//
//  ImageInterpolationExampleView.swift
//  Project16
//
//  Created by Piotr Chojnowski on 13/09/2022.
//

import SwiftUI

struct ImageInterpolationExampleView: View {
    var body: some View {
        Image("example")
            .interpolation(.none) // disable interpolation effect
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    }
}

struct ImageInterpolationExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ImageInterpolationExampleView()
    }
}
