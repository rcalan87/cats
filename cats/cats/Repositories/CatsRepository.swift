//
//  CatsRepository.swift
//  cats
//
//  Created by Alan Rodriguez on 02/07/24.
//

import Foundation

class CatsRepository: CatsQuery {
    func loadCats() async throws -> [Cat] {
        let url = "https://cataas.com/api/cats?&limit=20"
        let result: Result<[Cat]?, ServiceError> = await ServiceLayer.shared.getRequest(url: url)
        switch result {
        case .success(let data):
            guard let cats = data else { throw ServiceError.genericError }
            return cats
        case .failure(let error):
            throw error
        }
    }
}
