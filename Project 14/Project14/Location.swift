//
//  Location.swift
//  Project14
//
//  Created by Piotr Chojnowski on 08/09/2022.
//

import Foundation
import CoreLocation

struct Location: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Location(id: UUID(),
                                  name: "Palace",
                                  description: "Queen Elizabeth",
                                  latitude: 51.501, longitude: -0.141)
    
    // Equatable not required but optimizing, there's no need to compare by other types than UUID.
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
