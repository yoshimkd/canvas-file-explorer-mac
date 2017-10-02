//
//  AppDelegate.swift
//  CanvasFileExplorer
//
//  Created by Jovan Jovanovski on 5/28/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Cocoa

import CanvasScreen

class AppDelegate: NSObject, NSApplicationDelegate {
    
    let wireframe: CanvasScreen.Wireframe = CanvasScreen.Wireframe()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let controller = wireframe.viewController
        let window = NSWindow(
            contentRect: NSRect(x: 100, y: 100, width: 400, height: 400),
            styleMask: [.closable, .resizable, .titled, .fullSizeContentView],
            backing: .buffered,
            defer: true)
        
        window.contentViewController = controller
        window.makeKeyAndOrderFront(nil)
    }
    
}
