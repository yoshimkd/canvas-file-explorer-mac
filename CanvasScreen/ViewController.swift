//
//  ViewController.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/1/17.
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

struct SavedFilePosition {
    
    let filePath: String
    let point: CGPoint
    
}

class ViewController: NSViewController {
    
    @IBOutlet private weak var containerView: NSView!
    
    var filePathsPositionsFileURL: URL!
    
    var fileViews = [FileView]()
    var savedFilesPositions: [SavedFilePosition]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let documentsDirectoryUrl = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)[0]
        filePathsPositionsFileURL = documentsDirectoryUrl
            .appendingPathComponent("filePathsPositions.json")
        
        print("File paths positions file URL: \(filePathsPositionsFileURL)")
        
        savedFilesPositions = jsonFromFile()
        
        let openPanel = NSOpenPanel()
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        
        openPanel.begin {
            [unowned self, openPanel = openPanel] result in
            if result.rawValue == NSFileHandlingPanelOKButton {
                print("Chosen root directory: \(openPanel.url!.path)")
                self.drawFilesFromRoot(directory: openPanel.url!.path)
            }
        }
        
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor =
            CGColor(red: 246.0 / 255,
                    green: 246.0 / 255,
                    blue: 246.0 / 255,
                    alpha: 1)
        
        let panRecognizer = NSPanGestureRecognizer(
            target: self,
            action: #selector(ViewController.handlePan(sender:)))
        containerView.addGestureRecognizer(panRecognizer)
    }
    
    func jsonFromFile() -> [SavedFilePosition] {
        do {
            let data = try Data(contentsOf: filePathsPositionsFileURL)
            let json = try JSONSerialization.jsonObject(
                with: data, options: .mutableContainers) as! [[String: Any]]
            return json.map {
                dictionary in
                let filePath = dictionary["filePath"] as! String
                let position = dictionary["position"] as! [String: CGFloat]
                
                return SavedFilePosition(filePath: filePath,
                                         point: CGPoint(x: position["x"]!,
                                                        y: position["y"]!))
            }
        } catch {
            return []
        }
    }
    
    func dictionaryToJSONString(dictionary: [[String: Any]]) -> String {
        let theJSONData =
            try! JSONSerialization.data(withJSONObject: dictionary)
        return String(data: theJSONData,
                      encoding: .ascii)!
    }
    
    func writeToFile(string: String) {
        try! string.write(to: filePathsPositionsFileURL,
                          atomically: true,
                          encoding: .utf8)
    }
    
    func fileView1() -> FileView1 {
        var topLevelObjects: NSArray? = NSArray()
        Bundle(for: Wireframe.self).loadNibNamed(
            NSNib.Name("FileView"),
            owner: nil,
            topLevelObjects: &topLevelObjects)
        return topLevelObjects!.first {
            view in
            view is FileView1
            } as! FileView1
    }
    
    func drawFilesFromRoot(directory: String) {
        let allSwiftFilePaths = swiftFilePaths(
            inDirectoryWithFilePath: directory)
        
        print("Recognized swift files' paths: \(allSwiftFilePaths)")
        
        fileViews =
            allSwiftFilePaths.map {
                filePath in
                
                let fileName = (((filePath as NSString)
                    .lastPathComponent as NSString).deletingPathExtension)
                
                let fileView = self.fileView1()
                fileView.label.stringValue = fileName
                
                if let savedFilePosition =
                    savedFilesPositions.first(where: {
                        savedFilePosition in
                        return filePath == savedFilePosition.filePath
                    }) {
                    fileView.frame.origin = savedFilePosition.point
                } else {
                    fileView.frame.origin = CGPoint(x: 50, y: 50)
                }
                
                let panRecognizer = NSPanGestureRecognizer(
                    target: self,
                    action: #selector(ViewController.handlePan(sender:)))
                fileView.addGestureRecognizer(panRecognizer)
                
                let tapRecognizer = NSClickGestureRecognizer(
                    target: self,
                    action: #selector(ViewController.handleTap(sender:)))
                fileView.addGestureRecognizer(tapRecognizer)
                
                containerView.addSubview(fileView)
                
                return FileView(filePath: filePath, view: fileView)
        }
    }
    
    @objc func handlePan(sender: NSPanGestureRecognizer) {
        if sender.state == .changed || sender.state == .ended {
            let translation = sender.translation(in: sender.view!.superview!)
            
            if sender.view! === containerView {
                fileViews.forEach({
                    fileView in
                    fileView.view!.frame.origin = CGPoint(
                        x: fileView.view!.frame.origin.x + translation.x * 2,
                        y: fileView.view!.frame.origin.y + translation.y * 2)
                })
            } else {
                sender.view!.frame.origin = CGPoint(
                    x: sender.view!.frame.origin.x + translation.x,
                    y: sender.view!.frame.origin.y + translation.y)
            }
            
            sender.setTranslation(.zero, in: sender.view!.superview!)
        }
    }
    
    @objc func handleTap(sender: NSClickGestureRecognizer) {
        let filePath =
            fileViews.first {
                fileView in
                return fileView.view == sender.view
                }!.filePath
        NSWorkspace.shared.openFile(filePath)
    }
    
    @IBAction func saveButtonPushHandler(_ sender: NSButton) {
        let json =
            fileViews.map {
                fileView -> [String : Any] in
                let origin = fileView.view!.frame.origin
                return ["filePath": fileView.filePath,
                        "position": ["x": origin.x, "y": origin.y]]
        }
        
        writeToFile(string: dictionaryToJSONString(dictionary: json))
    }
    
    override func magnify(with event: NSEvent) {
        containerView.scaleUnitSquare(to: CGSize(
            width: event.magnification + 1, height: event.magnification + 1))
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
