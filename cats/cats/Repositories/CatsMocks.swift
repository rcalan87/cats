//
//  CatsMocks.swift
//  cats
//
//  Created by Alan Rodriguez on 02/07/24.
//

import Foundation
class CatsMocks: CatsQuery {
    func loadCats() async throws -> [Cat] {
        guard let data: Data = JSONParser.data(from: "Cats") else { throw ServiceError.mockupMissingError }
        
        do {
            let mockedCats = try JSONDecoder().decode([Cat].self, from: data)
            return mockedCats
        } catch {
            throw error
        }
    }
}
