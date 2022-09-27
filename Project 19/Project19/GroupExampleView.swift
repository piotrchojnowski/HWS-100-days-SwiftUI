//
//  GroupExampleView.swift
//  Project19
//
//  Created by Piotr Chojnowski on 26/09/2022.
//

import SwiftUI

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct GroupExampleView: View {
//    @State private var layoutVertically = false
//
//    var body: some View {
//        Group {
//            if layoutVertically {
//                VStack {
//                    UserView()
//                }
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
//        }
//        .onTapGesture {
//            layoutVertically.toggle()
//        }
//    }
    
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        if sizeClass == .compact {
            VStack(content: UserView.init) //or use below a closure.
        } else {
            HStack {
                UserView()
            }
        }
    }
}

struct GroupExampleView_Previews: PreviewProvider {
    static var previews: some View {
        GroupExampleView()
    }
}
