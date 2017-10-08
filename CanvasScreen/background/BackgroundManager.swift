//
//  BackgroundManager.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/6/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

final class BackgroundManager {
    
    private let filesMaybeInitialPositions: Set<FileMaybeInitialPosition>
    private let filePathSelectionHandler: (String) -> ()
    private let filesInitialPositionsSaver: (Set<FileInitialPosition>) -> ()
    
    var eventHandler: ((ScreenEvent, Bool) -> ())!
    
    init(filesMaybeInitialPositions: Set<FileMaybeInitialPosition>,
         filePathSelectionHandler: @escaping (String) -> (),
         filesInitialPositionsSaver:
        @escaping (Set<FileInitialPosition>) -> ()) {
        self.filesMaybeInitialPositions = filesMaybeInitialPositions
        self.filePathSelectionHandler = filePathSelectionHandler
        self.filesInitialPositionsSaver = filesInitialPositionsSaver
    }
    
    func presentFilesInitialPositions() {
        eventHandler(.filesMaybeInitialPositionsPresentationRequest(
            filesMaybeInitialPositions: filesMaybeInitialPositions),
                     true)
    }
    
    func handleFilePathSelection(filePath: String) {
        filePathSelectionHandler(filePath)
    }
    
    func handleFilePathsSave(filesInitialPositions: Set<FileInitialPosition>) {
        filesInitialPositionsSaver(filesInitialPositions)
    }
    
}
