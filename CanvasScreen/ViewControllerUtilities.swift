//
//  ViewControllerUtilities.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/1/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Cocoa

extension ViewController {
    
    static func createFromNib() -> ViewController {
        return ViewController(
            nibName: NSNib.Name("ViewController"),
            bundle: Bundle(for: Wireframe.self))
    }
    
}
