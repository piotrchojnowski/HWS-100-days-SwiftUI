//
//  FileManager-DocumentsDirectory.swift
//  Project14
//
//  Created by Piotr Chojnowski on 10/09/2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
