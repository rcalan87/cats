//
//  CatsDetailsViewModel.swift
//  cats
//
//  Created by Alan Rodriguez on 02/07/24.
//

import Foundation

class CatsDetailsViewModel {
    let url: String
    let tags: [String]
    
    init(id: String, tags: [String]) {
        self.url = "https://cataas.com/cat/\(id)"
        self.tags = tags
    }
}
