//
//  PackageExampleView.swift
//  Project16
//
//  Created by Piotr Chojnowski on 14/09/2022.
//

import SwiftUI
import SamplePackage

struct PackageExampleView: View {
    let possibleNumbers = Array(1...60)
    
    var body: some View {
        Text(results)
    }
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }
}

struct PackageExampleView_Previews: PreviewProvider {
    static var previews: some View {
        PackageExampleView()
    }
}
