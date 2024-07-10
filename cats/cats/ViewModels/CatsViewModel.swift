//
//  CatsViewModel.swift
//  cats
//
//  Created by Alan Rodriguez on 02/07/24.
//

import Foundation

protocol CatsView: AnyObject {
    func didSucceed(with cats: [Cat])
    func didFailed(with error: String)
}

class CatsViewModel {
    weak var view: CatsView?
    var repository: CatsRepository = CatsRepository()
    
    init(view: CatsView?) {
        self.view = view
    }
    
    func loadCats() {
        Task { @MainActor in
            do {
                let cats = try await repository.loadCats()
                view?.didSucceed(with: cats)
            } catch {
                view?.didFailed(with: error.localizedDescription)
            }
        }
    }
}
