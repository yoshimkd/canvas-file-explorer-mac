//
//  ViewController.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/1/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import AppKit

final class ViewController: NSViewController {
    
    var eventHandler: ((ScreenEvent, Bool) -> ())!
    
    @IBOutlet private weak var containerView: NSView!
    @IBOutlet private weak var containerViewPanRecognizer:
    NSPanGestureRecognizer!
    
    private var userInterfaceFiles = [Int: NSView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer!.backgroundColor = CGColor(
            red: 246.0 / 255,
            green: 246.0 / 255,
            blue: 246.0 / 255,
            alpha: 1)
        
        eventHandler(.userInterfaceLoaded, false)
    }
    
    func userInterfaceStatesDifferenceHandler(
        userInterfaceStatesDifference: UserInterfaceStatesDifference,
        animated: Bool,
        screenSignals: ScreenSignals?,
        completionHandler: @escaping () -> ()) {
        let block = {
            userInterfaceStatesDifference.newFilesElements.forEach {
                [unowned self] id, fileElement in
                let bubbleView = BubbleView.createFromNib()
                bubbleView.textField.stringValue = fileElement.text
                bubbleView.frame.origin = CGPoint(
                    x: CGFloat(fileElement.position.x),
                    y: CGFloat(fileElement.position.y))
                
                let panRecognizer = NSPanGestureRecognizer(
                    target: self,
                    action: #selector(self.panHandler))
                bubbleView.addGestureRecognizer(panRecognizer)
                
                let tapRecognizer = NSClickGestureRecognizer(
                    target: self,
                    action: #selector(self.tapHandler))
                bubbleView.addGestureRecognizer(tapRecognizer)
                
                self.containerView.addSubview(bubbleView)
                self.userInterfaceFiles[id] = bubbleView
            }
            
            userInterfaceStatesDifference.editedFilesElements.forEach {
                [unowned self] id, editedFileElement in
                self.userInterfaceFiles[id]!.frame.origin = CGPoint(
                    x: CGFloat(editedFileElement.position.x),
                    y: CGFloat(editedFileElement.position.y))
                
                (self.userInterfaceFiles[id]!.gestureRecognizers.first {
                    gestureRecognizer in
                    gestureRecognizer is NSPanGestureRecognizer
                    } as! NSPanGestureRecognizer)
                    .setTranslation(.zero, in: self.containerView)
            }
            
            if !userInterfaceStatesDifference.editedFilesElements.isEmpty {
                self.containerViewPanRecognizer.setTranslation(
                    .zero, in: self.view)
            }
            
            if let screenSignals = screenSignals {
                if case .handleBackgroundMagnificationChange(
                    let magnification) = screenSignals {
                    self.containerView.scaleUnitSquare(to: CGSize(
                        width: CGFloat(magnification),
                        height: CGFloat(magnification)))
                }
            }
        }
        
        if Thread.isMainThread {
            block()
            completionHandler()
        } else {
            DispatchQueue.main.async(execute: block)
            completionHandler()
        }
    }
    
    //MARK:
    //MARK: Actions' handlers
    //MARK:
    
    override func magnify(with event: NSEvent) {
        eventHandler(.backgroundMagnificationChangeRequest(
            magnification: Float(event.magnification) + 1), true)
    }
    
    @IBAction private func panHandler(_ sender: NSPanGestureRecognizer) {
        if sender.state == .changed || sender.state == .ended {
            let translation = sender.translation(in: sender.view!.superview!)
            
            if sender.view! === containerView {
                eventHandler(.backgroundPanned(
                    translation:
                    Point(x: Float(translation.x), y: Float(translation.y))),
                             true)
            } else {
                let id = userInterfaceFiles.first {
                    [recognizerView = sender.view!] id, view in
                    return recognizerView === view
                    }!.key
                eventHandler(.fileElementPanned(
                    id: id,
                    translation:
                    Point(x: Float(translation.x), y: Float(translation.y))),
                             true)
            }
        }
    }
    
    @objc private func tapHandler(recognizer: NSClickGestureRecognizer) {
        let id = userInterfaceFiles.first {
            [recognizerView = recognizer.view!] id, view in
            return recognizerView === view
            }!.key
        
        eventHandler(.fileElementSelected(id: id), true)
    }
    
    @IBAction private func saveButtonPushHandler(_ sender: NSButton) {
        eventHandler(.saveRequested, true)
    }
    
}
