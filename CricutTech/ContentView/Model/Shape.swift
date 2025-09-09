//
//  Shape.swift
//  CricutTech
//
//  Created by Tim McEwan on 9/4/25.
//

import Foundation

struct Shape: Decodable {
    let buttons: [Shapes]
}

struct Shapes: Decodable, Identifiable {
    let name: String
    let drawPath: String
    
    var id: String { return name }
}


