//
//  AlertSheetExampleView.swift
//  Project19
//
//  Created by Piotr Chojnowski on 26/09/2022.
//

import SwiftUI

struct User: Equatable, Identifiable {
    var id = "Taylor Swift"
}

//struct AlertSheetExampleView: View {
//    @State private var selectedUser: User? = nil
//
//    var body: some View {
//        Text("Hello, World!")
//            .onTapGesture {
//                selectedUser = User()
//            }
//            .sheet(item: $selectedUser) { user in
//                Text(user.id)
//            }
//    }
//}

// isPresented variant:

struct AlertSheetExampleView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false

    var body: some View {
        Text("Hello, World!")
            .onTapGesture {
                selectedUser = User()
                isShowingUser = true
            }
//            .sheet(isPresented: $isShowingUser) {
//                Text(selectedUser?.id ?? "Unknown")
//            }
            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
                Button(user.id) { }
            }
//            .onChange(of: selectedUser) { newValue in
//                print(newValue)
//            }
    }
}

struct AlertSheetExampleView_Previews: PreviewProvider {
    static var previews: some View {
        AlertSheetExampleView()
    }
}
