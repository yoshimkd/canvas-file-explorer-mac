//
//  FileInitialPosition.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/4/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

public struct FileInitialPosition: Hashable {
    
    public let filePath: String
    public let position: Point
    
    public struct Point {
        
        public let x: Float
        public let y: Float
        
    }
    
    public static func ==(fileInitialPosition1: FileInitialPosition,
                          fileInitialPosition2: FileInitialPosition) -> Bool {
        return fileInitialPosition1.filePath == fileInitialPosition2.filePath
    }
    
    public var hashValue: Int {
        return filePath.hashValue
    }
    
}
