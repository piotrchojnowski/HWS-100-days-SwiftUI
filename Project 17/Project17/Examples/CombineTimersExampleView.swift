//
//  CombineTimersExampleView.swift
//  Project17
//
//  Created by Piotr Chojnowski on 20/09/2022.
//

import SwiftUI

struct CombineTimersExampleView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }

                counter += 1
            }
    }
}

struct CombineTimersExampleView_Previews: PreviewProvider {
    static var previews: some View {
        CombineTimersExampleView()
    }
}
