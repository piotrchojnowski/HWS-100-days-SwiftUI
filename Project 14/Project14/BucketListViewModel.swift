//
//  BucketListViewModel.swift
//  Project14
//
//  Created by Piotr Chojnowski on 10/09/2022.
//

import Foundation
import MapKit
import LocalAuthentication

extension BucketListView {
    @MainActor class BucketListViewModel: ObservableObject {
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 54.37, longitude: 18.64),
                                                      span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var locations: [Location]
        @Published var selectedPlace: Location?
        
        @Published private(set) var isUnlocked = false
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
        
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation() {
            let newLocation = Location(id: UUID(),
                                       name: "New Location",
                                       description: "",
                                       latitude: mapRegion.center.latitude,
                                       longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace = selectedPlace else {
                return
            }

            guard let index = locations.firstIndex(of: selectedPlace) else {
                return
            }
            
            locations[index] = location
            save()
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { authSuccess, error in
                    if authSuccess {
//                        Approach #1
//                        Task {
//                            await MainActor.run {
//                                self.isUnlocked = true
//                            }
//                        }
                        // Approach #2 - compact version of above.
                        // That's because the changes cannot be published from a background thread.
                        Task { @MainActor in
                            self.isUnlocked = true
                        }
                        
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }
    }
}

