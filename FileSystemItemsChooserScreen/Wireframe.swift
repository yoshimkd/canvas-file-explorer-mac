//
//  Wireframe.swift
//  FileSystemItemsChooserScreen
//
//  Created by Jovan Jovanovski on 10/4/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import AppKit

public final class Wireframe {
    
    private let openPanel = NSOpenPanel()
    private let presentationCompletionHandler: ([URL]) -> ()
    
    public init(presentationCompletionHandler: @escaping ([URL]) -> ()) {
        openPanel.canChooseDirectories = true
        openPanel.allowsMultipleSelection = true
        self.presentationCompletionHandler = presentationCompletionHandler
    }
    
    public func present() {
        openPanel.begin(
            completionHandler: {
                [openPanel = openPanel,
                presentationCompletionHandler = presentationCompletionHandler]
                result in
                if result == .OK {
                    let urls = openPanel.urls
                    print("👁 Chosen file system items' paths: \(urls)")
                    presentationCompletionHandler(urls)
                }
            }
        )
    }
    
}
