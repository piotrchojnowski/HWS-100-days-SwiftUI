//
//  ScrollViewGeoExampleView.swift
//  Project18
//
//  Created by Piotr Chojnowski on 23/09/2022.
//

import SwiftUI

struct ScrollViewGeoExampleView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

//    var body: some View {
//        GeometryReader { fullView in
//            ScrollView {
//                ForEach(0..<50) { index in
//                    GeometryReader { geo in
//                        Text("Row #\(index)")
//                            .font(.title)
//                            .frame(maxWidth: .infinity)
//                            .background(colors[index % 7])
//                            .rotation3DEffect(
//                                .degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5,
//                                axis: (x: 0, y: 1, z: 0)
//                            )
//                    }
//                    .frame(height: 40)
//                }
//            }
//        }
//    }
    @State private var geoValue: CGRect = .zero
    
    func makeView(num: Int, geo: GeometryProxy) -> some View {
        
        if num == 1 {
            print(geo.frame(in: .global))
        }
        
        return Text("Number \(num)")
            .font(.largeTitle)
            .frame(width: 200, height: 200)
            .background(.red)
            .rotation3DEffect(
                .degrees(-geo.frame(in: .global).minX) / 120,
                axis: (x: 0, y: 1, z: 0)
            )
            .frame(width: 200, height: 200)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                Spacer(minLength: 100)
                ForEach(1..<20) { num in
                    
                    GeometryReader { geo in
                        makeView(num: num, geo: geo)
                            .position(x:100, y: geo.frame(in: .local).midY)
                    }
                    .frame(width: 200, height: 400)
                }
            }
        }
    }
}

struct ScrollViewGeoExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewGeoExampleView()
    }
}
