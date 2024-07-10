//
//  Cats.swift
//  cats
//
//  Created by Alan Rodriguez on 02/07/24.
//

import Foundation

struct Cat: Codable {
    let id: String
    let type: String
    let size: Int
    let tags: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case type = "mimetype"
        case size, tags
    }
}
