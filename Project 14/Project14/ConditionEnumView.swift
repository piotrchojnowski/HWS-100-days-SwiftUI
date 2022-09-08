//
//  ConditionEnumView.swift
//  Project14
//
//  Created by Piotr Chojnowski on 08/09/2022.
//

import SwiftUI

enum LoadingState: CaseIterable {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading")
            .frame(width: 200, height: 200, alignment: .center)
            .background(Color.gray)
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success")
            .frame(width: 300, height: 100, alignment: .center)
            .background(Color.green)
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed")
            .frame(width: 100, height: 100, alignment: .center)
            .background(Color.red)
    }
}

struct ConditionEnumView: View {
    @State private var loadingState = LoadingState.loading
    
    var body: some View {
        
        VStack {
            Spacer()
            
            switch loadingState {
            case .loading:
                LoadingView()
            case .success:
                SuccessView()
            case .failed:
                FailedView()
            }
            
            Spacer()
            
            Button("Swap screens") {
                loadingState = LoadingState.allCases.randomElement() ?? .loading
            }
        }
        
        
    }
}

struct ConditionEnumView_Previews: PreviewProvider {
    static var previews: some View {
        ConditionEnumView()
    }
}
