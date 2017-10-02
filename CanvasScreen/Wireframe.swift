//
//  Wireframe.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/1/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Cocoa

public class Wireframe {
    
    public let viewController: NSViewController
    
    public init() {
        let viewController = ViewController.createFromNib()
        self.viewController = viewController
    }
    
}
