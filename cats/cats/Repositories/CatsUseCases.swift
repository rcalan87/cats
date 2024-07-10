//
//  CatsUseCases.swift
//  cats
//
//  Created by Alan Rodriguez on 02/07/24.
//

import Foundation

protocol CatsFetchQuery: AnyObject {
    func loadCats() async throws -> [Cat]
}

protocol CatsQuery: CatsFetchQuery {}
