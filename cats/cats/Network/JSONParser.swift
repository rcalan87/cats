//
//  JSONParser.swift
//  cats
//
//  Created by Alan Rodriguez on 02/07/24.
//

import Foundation

final class JSONParser: Sendable {
    
    private init() {}
    
    @Sendable static func data(from json: String) -> Data? {
        do {
            guard let path: String = Bundle.main.path(forResource: json, ofType: "json") else {
                return nil
            }
            let url: URL = URL(fileURLWithPath: path)
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return nil
        }
    }
}
