//
//  JsonLoader.swift
//  TriBikesUnitTests
//
//  Created by Roman on 19/05/2024.
//

import Foundation

class JsonLoader {
    static func load(file: String) throws -> Data {
        guard
            let path = Bundle(for: self).path(forResource: file, ofType: "json")
            else { fatalError("Can't find file: \(file)") }
        
        return try Data(contentsOf: URL(fileURLWithPath: path))
    }
}
