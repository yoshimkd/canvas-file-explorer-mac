//
//  FileMaybeInitialPosition.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/8/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

public struct FileMaybeInitialPosition: Hashable {
    
    let filePath: String
    let position: Point?
    
    public struct Point {
        
        let x: Float
        let y: Float
        
        public init(x: Float, y: Float) {
            self.x = x
            self.y = y
        }
        
    }
    
    public init(filePath: String,
                position: Point?) {
        self.filePath = filePath
        self.position = position
    }
    
    public static func ==(
        fileMaybeInitialPosition1: FileMaybeInitialPosition,
        fileMaybeInitialPosition2: FileMaybeInitialPosition) -> Bool {
        return fileMaybeInitialPosition1.filePath ==
            fileMaybeInitialPosition2.filePath
    }
    
    public var hashValue: Int {
        return filePath.hashValue
    }
    
}
