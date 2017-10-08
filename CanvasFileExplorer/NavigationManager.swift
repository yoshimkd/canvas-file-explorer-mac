//
//  NavigationManager.swift
//  CanvasFileExplorer
//
//  Created by Jovan Jovanovski on 10/4/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import AppKit

final class NavigationManager {
    
    //MARK:
    //MARK: Properties
    
    private let modulesManager = ModulesManager()
    private let window = NSWindow(
        contentRect: NSRect(x: 100, y: 100, width: 600, height: 600),
        styleMask: [.closable, .resizable, .titled, .fullSizeContentView],
        backing: .buffered,
        defer: true)
    
    //MARK:
    //MARK: Methods
    
    func startPresenting() {
        modulesManager.getFilesInitialPositions()
        modulesManager.createFileSystemItemsChooserScreenWireframe(
            presentationCompletionHandler: {
                [modulesManager = modulesManager, window = window] in
                modulesManager.createCanvasScreenWireframe(
                    filePathSelectionHandler: {
                        filePath in
                        NSWorkspace.shared.openFile(filePath)
                })
                window.contentViewController =
                    modulesManager.canvasScreenWireframe!.viewController
                window.makeKeyAndOrderFront(nil)
        })
        
        modulesManager.fileSystemItemsChooserScreenWireframe!.present()
    }
    
}
