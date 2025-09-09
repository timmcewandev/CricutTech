//
//  CricutTechTests.swift
//  CricutTechTests
//
//  Created by Tim McEwan on 9/4/25.
//

import XCTest
@testable import CricutTech

struct NetworkMock: HTTP {
    var isLoading = false
    
    var shapes: [Shapes] = []
    
    func getShape() async throws -> [CricutTech.Shapes] {
        if isLoading {
            shapes
        } else {
            throw NetworkError.invalidDecode
        }
    }
    
}

final class CricutTechTests: XCTestCase {
    
    @MainActor func testPerformanceExample() throws {
        let mock = NetworkMock()
        let viewModel = ViewModel(networkManager: mock)
        
        let circle = Shapes(name: "Circle", drawPath: "circle")
        let square = Shapes(name: "Square", drawPath: "square")
        
        viewModel.shape.append(circle)
        viewModel.shape.append(square)
        
        XCTAssertEqual(viewModel.shape.count, 2)
        XCTAssertEqual(viewModel.shape[0].name, "Circle")
    }

}
