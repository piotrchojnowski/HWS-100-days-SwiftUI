//
//  WelcomeView.swift
//  Project19
//
//  Created by Piotr Chojnowski on 27/09/2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            
            Text("Please select resort from left hand menu.")
                .foregroundColor(.secondary)
        }
        
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
