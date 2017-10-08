//
//  BackgroundManagerProtocol.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/6/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

protocol BackgroundManagerProtocol: class {
    
    func presentFilesInitialPositions()
    func handleFilePathSelection(filePath: String)
    func handleFilePathsSave(filesInitialPositions: Set<FileInitialPosition>)
    
}
