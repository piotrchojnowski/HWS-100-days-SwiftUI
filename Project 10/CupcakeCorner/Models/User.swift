//
//  User.swift
//  CupcakeCorner
//
//  Created by Piotr Chojnowski on 07/04/2021.
//

import Foundation

class User: Codable, ObservableObject {
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    @Published var name: String = "Piotr Chojnowski"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
