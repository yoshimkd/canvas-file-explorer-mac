//
//  ModulesManager.swift
//  CanvasFileExplorer
//
//  Created by Jovan Jovanovski on 10/4/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import FileSystemItemsChooserScreen
import FilesInitialPositionsCacheModule
import FileSystemHelper
import CanvasScreen

final class ModulesManager {
    
    //MARK:
    //MARK: Properties
    
    var fileSystemItemsChooserScreenWireframe:
    FileSystemItemsChooserScreen.Wireframe?
    var canvasScreenWireframe: CanvasScreen.Wireframe?
    
    var savedFilesInitialPositions:
    Set<FilesInitialPositionsCacheModule.FileInitialPosition>!
    var chosenFilesMaybeInitialPositions:
    Set<CanvasScreen.FileMaybeInitialPosition>!
    
    func getFilesInitialPositions() {
        savedFilesInitialPositions =
            FilesInitialPositionsCache.savedFilesInitialPositions()
    }
    
    func createFileSystemItemsChooserScreenWireframe(
        presentationCompletionHandler: @escaping () -> ()) {
        fileSystemItemsChooserScreenWireframe =
            FileSystemItemsChooserScreen.Wireframe(
                presentationCompletionHandler: {
                    [unowned self] urls in
                    let files =
                        FileSystemHelper.getFiles(inFileSystemItems: urls)
                    
                    self.chosenFilesMaybeInitialPositions = Set(files.map {
                        file -> CanvasScreen.FileMaybeInitialPosition in
                        if let fileIntialPosition =
                            self.savedFilesInitialPositions.first(where: {
                                [file = file] fileIntialPosition in
                                return file.path ==
                                    fileIntialPosition.filePath
                            }) {
                            return CanvasScreen.FileMaybeInitialPosition(
                                filePath: fileIntialPosition.filePath,
                                position: CanvasScreen.FileMaybeInitialPosition
                                    .Point(x: fileIntialPosition.position.x,
                                           y: fileIntialPosition.position.y))
                        }
                        
                        return CanvasScreen.FileMaybeInitialPosition(
                            filePath: file.path,
                            position: nil)
                    })
                    
                    presentationCompletionHandler()
                }
        )
    }
    
    func createCanvasScreenWireframe(
        filePathSelectionHandler: @escaping (String) -> ()) {
        canvasScreenWireframe = CanvasScreen.Wireframe(
            filesMaybeInitialPositions: chosenFilesMaybeInitialPositions,
            filePathSelectionHandler: filePathSelectionHandler,
            filesInitialPositionsSaver: {
                filesInitialPositions in
                FilesInitialPositionsCache.save(
                    filesInitialPositions: Set(filesInitialPositions.map {
                        fileInitialPosition in
                        return FilesInitialPositionsCacheModule
                            .FileInitialPosition(
                                filePath: fileInitialPosition.filePath,
                                position: FilesInitialPositionsCacheModule
                                    .FileInitialPosition.Point(
                                        x: fileInitialPosition.position.x,
                                        y: fileInitialPosition.position.y))
                    })
                )
        })
    }
    
}
