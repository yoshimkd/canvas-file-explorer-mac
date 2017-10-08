//
//  Point.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/8/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

struct Point: Equatable {
    
    var x: Float
    var y: Float
    
    static func ==(point1: Point, point2: Point) -> Bool {
        return point1.x == point2.x && point1.y == point2.y
    }
    
}
