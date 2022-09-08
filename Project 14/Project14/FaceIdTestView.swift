//
//  FaceIdTestView.swift
//  Project14
//
//  Created by Piotr Chojnowski on 08/09/2022.
//

import SwiftUI
import LocalAuthentication

struct FaceIdTestView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("UNLOCKED")
            } else {
                Text("LOCKED")
            }
        }
        .onAppear {
            authenticate()
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authError in
                if success {
                    // auth OK
                    isUnlocked = true
                } else {
                    // problem
                }
            }
        } else {
            // no biometrics
        }
    }
}

struct FaceIdTestView_Previews: PreviewProvider {
    static var previews: some View {
        FaceIdTestView()
    }
}
