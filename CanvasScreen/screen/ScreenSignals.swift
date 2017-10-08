//
//  ScreenSignals.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/5/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

enum ScreenSignals {
    
    case requestFilesInitialPositions
    case handleBackgroundMagnificationChange(magnification: Float)
    case handleFileElementSelection(filePath: String)
    case handleFilesInitialPositionsSave(
        filesInitialPositions: Set<FileInitialPosition>)
    
}
