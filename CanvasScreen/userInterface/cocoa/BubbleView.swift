//
//  BubbleView.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/2/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import AppKit

final class BubbleView: NSView {
    
    @IBOutlet weak var textField: NSTextField!
    
    static func createFromNib() -> BubbleView {
        var topLevelObjects: NSArray? = NSArray()
        Bundle(for: BubbleView.self).loadNibNamed(
            NSNib.Name("BubbleView"),
            owner: nil,
            topLevelObjects: &topLevelObjects)
        return topLevelObjects!.first {
            view in
            view is BubbleView
            } as! BubbleView
    }
    
}
