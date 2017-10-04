//
//  Wireframe.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/1/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Cocoa

public class Wireframe {
    
    private let filesInitialPositionsSaver: ([FileInitialPosition]) -> ()
    public let viewController: NSViewController
    
    public init(
        filesInitialPositions: [FileInitialPosition],
        filesInitialPositionsSaver: @escaping ([FileInitialPosition]) -> ()) {
        let viewController = ViewController.createFromNib()
        viewController.filesInitialPositions = filesInitialPositions
        
        
        self.viewController = viewController
        
        self.filesInitialPositionsSaver = filesInitialPositionsSaver
        viewController.filesInitialPositionsSaver = filesInitialPositionsSaver
        
    }
    
}
