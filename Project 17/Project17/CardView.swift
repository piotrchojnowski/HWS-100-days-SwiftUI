//
//  CardView.swift
//  Project17
//
//  Created by Piotr Chojnowski on 20/09/2022.
//

import SwiftUI

struct CardView: View {
    let card: Card
    var removal: (() -> Void)? = nil
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differantiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    @State private var feedback = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differantiateWithoutColor
                    ? .white
                    : .white.opacity(1 - Double(abs(offset.width / 200)))
                )
                .background(
                    differantiateWithoutColor
                    ? nil
                    : RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(cardBackgroundColor(offset))
                )
                .shadow(radius: 10)

            VStack {
                if voiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                        .foregroundColor(.black)

                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 10)))
        .offset(x: offset.width * 2, y: 0)
        .opacity(2 - Double(abs(offset.width / 150)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 200 {
                        if offset.width < 0 {
                            feedback.notificationOccurred(.error)
                        }

                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
        .onTapGesture {
            withAnimation {
                isShowingAnswer.toggle()
            }
            
        }
        .animation(.spring(), value: offset)
        .onChange(of: offset) { newValue in
            print("offset: \(offset.width)")
        }
    }
    
    private func cardBackgroundColor(_ offset: CGSize) -> Color {
        switch offset.width {
        case ..<0:
            return Color.red
        case 0:
            return Color.white
        default:
            return Color.green
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card.example)
    }
}
