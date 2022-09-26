//
//  ContentView.swift
//  Project18
//
//  Created by Piotr Chojnowski on 22/09/2022.
//

import SwiftUI

extension VerticalAlignment {
    struct MidAccountAndName: AlignmentID {
        static func defaultValue(in d: ViewDimensions) -> CGFloat {
            d[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct ContentView: View {
//    var body: some View {
//        VStack {
//            Text("Hello, world! Hello")
//                .frame(width: 100, height: 100, alignment: .leading)
//                .offset(CGSizeMake(50, 0))
//                .background(.gray)
//            HStack(alignment: .firstTextBaseline) {
//                Text("One")
//                    .font(.caption)
//                Text("Two")
//                    .font(.callout)
//                Text("Three")
//                    .font(.title)
//                Text("Four")
//                    .font(.largeTitle)
//            }
//        }
//        .padding()
//    }
    
//    var body: some View {
//        VStack(alignment: .leading) {
//            ForEach(0..<10) { position in
//                Text("Number \(position)")
//                    .alignmentGuide(.leading) { _ in
//                        CGFloat(position) * -10
//                    }
//            }
//        }
//        .background(.red)
//        .frame(width: 400, height: 400)
//        .background(.blue)
//    }
    
//    var body: some View {
//        HStack(alignment: .midAccountAndName) {
//            VStack {
//                Text("@twostraws")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                Image("paul-hudson")
//                    .resizable()
//                    .frame(width: 64, height: 64)
//            }
//
//            VStack {
//                Text("Full name:")
//                Text("PAUL HUDSON")
//                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
//                    .font(.largeTitle)
//            }
//        }
//    }
    
//    var body: some View {
//        Text("HELLO WORLD!")
//            .background(.green)
//            .position(x: 100, y: 100)
//            .background(.orange)
//            .offset(CGSize(width: 100, height: 100))
//            .background(.red)
//    }
    
    var body: some View {
        OuterView()
            .background(.brown)
            .coordinateSpace(name: "Custom")
    }
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
                .background(.cyan, ignoresSafeAreaEdges: [])
            InnerView()
                .background(.green)
            Text("Bottom")
                .background(.cyan)
        }
    }
}

struct InnerView: View {
    
    @State private var center = CGPoint.zero
    
    var rectangle: some View {
        Circle()
            .frame(width: 16, height: 16)
            .foregroundColor(.red)
            .position(x: center.x, y: center.y)
    }
    
    var body: some View {
        ZStack {
            HStack {
                Text("Left")
                GeometryReader { geo in
                    Text("Center elements - click me")
                        .background(.red)
                        .onTapGesture {
                            center = CGPoint(x: geo.frame(in: .named("Custom2")).midX,
                                             y: geo.frame(in: .named("Custom2")).midY)
                            
                            print("Global center: \(geo.frame(in: .global).midX) x \(geo.frame(in: .global).midY)\n \(geo.frame(in: .global).size)")
                            print("Custom center: \(geo.frame(in: .named("Custom")).midX) x \(geo.frame(in: .named("Custom")).midY) \n \(geo.frame(in: .named("Custom")).size)")
                            print("Local center: \(geo.frame(in: .local).midX) x \(geo.frame(in: .local).midY) \n \(geo.frame(in: .local).size)")
                        }
                }
                .background(.orange)
                Text("Right right")
            }
            
            
            Text("Center")
                .background(.blue)
                .position(x: center.x, y: center.y)
            rectangle
                .allowsHitTesting(false)
                
        }
        .coordinateSpace(name: "Custom2")

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
