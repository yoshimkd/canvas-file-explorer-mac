//
//  ModulesManager.swift
//  CanvasFileExplorer
//
//  Created by Jovan Jovanovski on 10/4/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Foundation

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
    [FilesInitialPositionsCacheModule.FileInitialPosition]!
    var chosenFilesInitialPositions:
    [CanvasScreen.FileInitialPosition]!
    
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
                    
                    self.chosenFilesInitialPositions = files.map {
                        file -> CanvasScreen.FileInitialPosition in
                        if let fileIntialPosition =
                            self.savedFilesInitialPositions.first(where: {
                                [file = file] fileIntialPosition in
                                return file.path ==
                                    fileIntialPosition.filePath
                            }) {
                            return CanvasScreen.FileInitialPosition(
                                filePath: fileIntialPosition.filePath,
                                point: fileIntialPosition.point)
                        }
                        
                        return CanvasScreen.FileInitialPosition(
                            filePath: file.path,
                            point: nil)
                    }
                    
                    presentationCompletionHandler()
                }
        )
    }
    
    func createCanvasScreenWireframe() {
        canvasScreenWireframe = CanvasScreen.Wireframe(
            filesInitialPositions: chosenFilesInitialPositions,
            filesInitialPositionsSaver: {
                filesInitialPositions in
                FilesInitialPositionsCache.save(
                    filesInitialPositions: filesInitialPositions.map {
                        fileInitialPosition in
                        return FilesInitialPositionsCacheModule
                            .FileInitialPosition(
                                filePath: fileInitialPosition.filePath,
                                point: fileInitialPosition.point!)
                })
        })
    }
    
}
