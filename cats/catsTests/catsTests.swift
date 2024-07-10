//
//  catsTests.swift
//  catsTests
//
//  Created by Alan Rodriguez on 30/06/24.
//

import XCTest
@testable import cats

final class catsTests: XCTestCase {
    let repository = CatsMocks()
    
    func testLoadCats() async throws {
        do {
            let cats = try await repository.loadCats()
            let firstCat = cats.first
            XCTAssertFalse(cats.isEmpty)
            XCTAssert(firstCat?.tags.first == "tuxedo")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
