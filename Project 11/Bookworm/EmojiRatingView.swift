//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Piotr Chojnowski on 09/04/2021.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int16
    
    var body: some View {
        Text(emoji(for: rating))
    }
    
    func emoji(for rating: Int16) -> String {
        switch rating {
        case 1:
            return "😖"
        case 2:
            return "😣"
        case 3:
            return "😐"
        case 4:
            return "🤭"
        case 5:
            return "😲"
        default:
            return "🤷‍♂️"
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 4)
    }
}
