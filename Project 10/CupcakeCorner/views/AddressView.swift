//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Piotr Chojnowski on 08/04/2021.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.model.name)
                TextField("Street address", text: $order.model.streetAddress)
                TextField("City", text: $order.model.city)
                TextField("Zip", text: $order.model.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Checkout")
                }
                .disabled(!order.model.hasValidAddress)
            }
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
