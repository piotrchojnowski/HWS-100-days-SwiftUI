//
//  Order.swift
//  CupcakeCorner
//
//  Created by Piotr Chojnowski on 08/04/2021.
//

import Foundation

class Order: ObservableObject, Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    enum CodingKeys: CodingKey {
        case model
    }
    
    @Published var model: OrderModel
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(model, forKey: .model)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        model = try container.decode(OrderModel.self, forKey: .model)
    }
    
    init() {
        model = OrderModel()
    }
}

struct OrderModel: Codable {
    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}

extension OrderModel {
    
    func validateWhitespaces(with string: String) -> Bool {
        return !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var hasValidAddress: Bool {
        guard validateWhitespaces(with: streetAddress),
              validateWhitespaces(with: name),
              validateWhitespaces(with: city),
              validateWhitespaces(with: zip) else {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
}

