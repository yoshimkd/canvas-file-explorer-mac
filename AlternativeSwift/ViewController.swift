//
//  ViewController.swift
//  AlternativeSwift
//
//  Created by Jovan Jovanovski on 5/28/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Cocoa

class FileView {
    
    let filePath: String
    weak var view: NSView?
    
    init(filePath: String,
         view: NSView?) {
        self.filePath = filePath
        self.view = view
    }
    
}

class ViewController: NSViewController {
    
    var fileViews = [FileView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        
        openPanel.begin {
            [unowned self] result in
            if result == NSFileHandlingPanelOKButton {
                self.drawFilesFromRoot(directory: openPanel.url!.path)
            }
        }
    }
    
    func drawFilesFromRoot(directory: String) {
        let allSwiftFilePaths = swiftFilePaths(
            inDirectoryWithFilePath: directory)
        
        fileViews =
            allSwiftFilePaths.map {
                filePath in
                
                let fileName = (((filePath as NSString)
                    .lastPathComponent as NSString).deletingPathExtension)
                
                let fileView = NSTextField(labelWithString: fileName)
                fileView.frame.origin = CGPoint(x: 50, y: 50)
                fileView.drawsBackground = true
                fileView.backgroundColor = NSColor.black
                fileView.textColor = NSColor.white
                view.addSubview(fileView)
                
                let panRecognizer = NSPanGestureRecognizer(
                    target: self,
                    action: #selector(ViewController.handlePan(sender:)))
                fileView.addGestureRecognizer(panRecognizer)
                
                let tapRecognizer = NSClickGestureRecognizer(
                    target: self,
                    action: #selector(ViewController.handleTap(sender:)))
                fileView.addGestureRecognizer(tapRecognizer)
                
                view.addSubview(fileView)
                
                return FileView(filePath: filePath, view: fileView)
        }
    }
    
    func handlePan(sender: NSPanGestureRecognizer) {
        if sender.state == .changed || sender.state == .ended {
            let trans = sender.translation(in: sender.view!.superview!)
            sender.view!.frame.origin = CGPoint(
                x: sender.view!.frame.origin.x + trans.x,
                y: sender.view!.frame.origin.y + trans.y)
            sender.setTranslation(.zero, in: sender.view!.superview!)
        }
    }
    
    func handleTap(sender: NSClickGestureRecognizer) {
        let filePath =
            fileViews.first {
                fileView in
                return fileView.view == sender.view
                }!.filePath
        NSWorkspace.shared().openFile(filePath)
    }
    
}

extension NSView {
    
    var backgroundColor: NSColor? {
        get {
            if let colorRef = self.layer?.backgroundColor {
                return NSColor(cgColor: colorRef)
            } else {
                return nil
            }
        }
        set {
            self.wantsLayer = true
            self.layer?.backgroundColor = newValue?.cgColor
        }
    }
}

func swiftFilePaths(
    inDirectoryWithFilePath directoryFilePath: String) -> [String] {
    let filesSubPaths = try!
        FileManager.default.subpathsOfDirectory(atPath: directoryFilePath)
    return
        (filesSubPaths as [NSString]).filter {
            fileSubPath in
            return fileSubPath.pathExtension == "swift"
            }.map {
                fileSubPath in
                return (directoryFilePath as NSString)
                    .appendingPathComponent(fileSubPath as String)
    }
}
