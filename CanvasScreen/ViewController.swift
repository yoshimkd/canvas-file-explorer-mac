//
//  ViewController.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/1/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Cocoa

enum Direction : Int {
    case west = 0
    case southWest = 1
    case south = 2
    case southEast = 3
    case east = 4
    case northEast = 5
    case north = 6
    case northWest = 7
}

class FileView {
    
    let filePath: String
    weak var view: NSView?
    
    init(filePath: String,
         view: NSView?) {
        self.filePath = filePath
        self.view = view
    }
    
}
final class ViewController: NSViewController {
    
    @IBOutlet private weak var containerView: NSView!
    
    var filesInitialPositions: [FileInitialPosition]!
    
    var fileViews = [FileView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.wantsLayer = true
        containerView.layer?.backgroundColor =
            CGColor(red: 246.0 / 255,
                    green: 246.0 / 255,
                    blue: 246.0 / 255,
                    alpha: 1)
        
        drawFiles()
        
        let panRecognizer = NSPanGestureRecognizer(
            target: self,
            action: #selector(ViewController.handlePan(sender:)))
        containerView.addGestureRecognizer(panRecognizer)
    }
    
    func dictionaryToJSONString(dictionary: [[String: Any]]) -> String {
        let theJSONData =
            try! JSONSerialization.data(withJSONObject: dictionary)
        return String(data: theJSONData,
                      encoding: .ascii)!
    }
    
    func writeToFile(string: String) {
        let documentsDirectoryURL = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)[0]
        let filePathsPositionsFileURL = documentsDirectoryURL
            .appendingPathComponent("filePathsPositions.json")
        
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
    
    func drawFiles() {
        var direction: Direction = .west
        var counter = 0
        fileViews =
            filesInitialPositions.map {
                fileInitialPosition in
                let fileName = (((fileInitialPosition.filePath as NSString)
                    .lastPathComponent as NSString).deletingPathExtension)
                
                let fileView = self.fileView1()
                fileView.label.stringValue = fileName
                
                if let initialPosition = fileInitialPosition.point {
                    fileView.frame.origin = initialPosition
                } else {
                    fileView.frame.origin = self.point(forDirection: direction, counter: counter)
                }
                
                counter += 1
                var nextDirection = direction.rawValue + 1
                if nextDirection > 7 {
                    counter += 1
                    nextDirection = 0
                }
                direction = Direction(rawValue: nextDirection)!
                
                let panRecognizer = NSPanGestureRecognizer(
                    target: self,
                    action: #selector(ViewController.handlePan(sender:)))
                fileView.addGestureRecognizer(panRecognizer)
                
                let tapRecognizer = NSClickGestureRecognizer(
                    target: self,
                    action: #selector(ViewController.handleTap(sender:)))
                fileView.addGestureRecognizer(tapRecognizer)
                
                containerView.addSubview(fileView)
                
                return FileView(
                    filePath: fileInitialPosition.filePath, view: fileView)
        }
    }
    
    func point(forDirection direction: Direction, counter: Int) -> CGPoint {
        let padding = counter > 2 ? 10 : 100
        let paddingReferent = 20
        let size = 50
        let negativeValue = -counter * padding - size
        let positiveValue = counter * padding + size
        let positiveReferent = counter * paddingReferent + size
        let negativeReferent = -counter * paddingReferent - size
        let referent = counter % 2 == 0 ? 20 : -20
        switch direction {
        case .west:
            return CGPoint(x: negativeReferent, y: referent)
        case .southWest:
            return CGPoint(x: negativeValue, y: positiveValue)
        case .south:
            return CGPoint(x: referent, y: positiveValue)
        case .southEast:
            return CGPoint(x: positiveValue, y: positiveValue)
        case .east:
            return CGPoint(x: positiveReferent, y: referent)
        case .northEast:
            return CGPoint(x: positiveValue, y: negativeValue)
        case .north:
            return CGPoint(x: referent, y: negativeValue)
        case .northWest:
            return CGPoint(x: negativeValue, y: negativeValue)
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
        
        print(filePath)
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
