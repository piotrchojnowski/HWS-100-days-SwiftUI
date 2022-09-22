//
//  Card.swift
//  Project17
//
//  Created by Piotr Chojnowski on 20/09/2022.
//

import Foundation

struct Card: Codable {
    let prompt: String
    let answer: String

    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
