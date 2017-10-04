//
//  FileInitialPosition.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/4/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import CoreGraphics

public struct FileInitialPosition {
    
    let filePath: String
    let point: CGPoint?
    
    public init(filePath: String,
                point: CGPoint?) {
        self.filePath = filePath
        self.point = point
    }
    
}