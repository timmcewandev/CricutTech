//
//  NetworkManager.swift
//  CricutTech
//
//  Created by Tim McEwan on 9/4/25.
//

import Foundation


protocol HTTP {
    func getShape() async throws -> [Shapes]
}

actor NetworkManager: HTTP {
    func getShape() async throws -> [Shapes] {
        guard let url = URL(string: "https://staticcontent.cricut.com/static/test/shapes_001.json") else {
            throw NetworkError.invalidString
        }
        let myURL = URLRequest(url: url)
        do {
            let (data, _) = try await URLSession.shared.data(for: myURL)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let myResult = try decoder.decode(Shape.self, from: data)
            
            return myResult.buttons
        } catch {
            throw NetworkError.invalidDecode
        }
    }
}

enum NetworkError: Error {
    case invalidString
    case invalidDecode
}
