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
    
    var window: NSWindow!
    let wireframe: CanvasScreen.Wireframe = CanvasScreen.Wireframe()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let controller = wireframe.viewController
        window = NSWindow(
            contentRect: NSRect(x: 100, y: 100, width: 600, height: 600),
            styleMask: [.closable, .resizable, .titled, .fullSizeContentView],
            backing: .buffered,
            defer: true)
        
        window.contentViewController = controller
        window.makeKeyAndOrderFront(nil)
    }
    
}
