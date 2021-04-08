//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Piotr Chojnowski on 08/04/2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
