//
//  main.swift
//  CanvasFileExplorer
//
//  Created by Jovan Jovanovski on 10/2/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import AppKit

let app = NSApplication.shared
let appDelegate = AppDelegate()
app.delegate = appDelegate
_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
