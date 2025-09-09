//
//  ViewModel.swift
//  CricutTech
//
//  Created by Tim McEwan on 9/4/25.
//

import Foundation
import Combine

@MainActor
class ViewModel: ObservableObject {
    let circleString = "circle.fill"
    @Published var shape: [Shapes] = []
    @Published var masterShapes: [String] = []
    @Published var circleShapes: [String] = []
    @Published var isLoading = true
    
    let networkManager: HTTP
    
    init(networkManager: HTTP = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getButton() async {
        defer { isLoading = false }
        do {
            let result = try await networkManager.getShape()
            shape = result
        } catch {
            
        }
    }
    
    //MARK: Add Circle
    
    func addNewShape(shape: String) {
        if let shapeNew = ShapesCategories(rawValue: shape) {
            masterShapes.append(shapeNew.shapeIcon)
        }
        
    }
    
    func filterToCircle() {
        circleShapes = masterShapes
        circleShapes = circleShapes.filter { $0 == circleString }
    }
    
    func addACircle() {
        if let shapeNew = ShapesCategories(rawValue: "Circle") {
            circleShapes.append(shapeNew.shapeIcon)
            masterShapes.append(shapeNew.shapeIcon)
        }
    }
    
    func removeCircle() {
        if circleShapes.isEmpty {
            return
        }
        circleShapes.removeLast()
        if let index = masterShapes.lastIndex(of: circleString) {
            masterShapes.remove(at: index)
        }
    }
    
    func removeAllCirclesFromMasterList() {
        circleShapes.removeAll()
        masterShapes = masterShapes.filter { $0 != circleString }
    }
    
    func removeAllShapes() {
        masterShapes.removeAll()
    }
}

enum ShapesCategories: String, CaseIterable {
    case circle = "Circle"
    case square = "Square"
    case triangle = "Triangle"
    
    var shapeIcon: String {
        switch self {
        case .circle:
            return "circle.fill"
        case .square:
            return "square.fill"
        case .triangle:
            return "triangle.fill"
        }
    }
}
