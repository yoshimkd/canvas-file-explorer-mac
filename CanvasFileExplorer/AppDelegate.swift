//
//  AppDelegate.swift
//  CanvasFileExplorer
//
//  Created by Jovan Jovanovski on 5/28/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import AppKit

final class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let navigationManager = NavigationManager()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        navigationManager.startPresenting()
    }
    
}
