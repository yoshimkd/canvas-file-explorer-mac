//
//  BackgroundStatesDifferenceApplier.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/6/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

final class BackgroundStatesDifferenceApplier {
    
    private let backgroundManager: BackgroundManagerProtocol
    
    init(backgroundManager: BackgroundManagerProtocol) {
        self.backgroundManager = backgroundManager
    }
    
    func applier(statesDifference: BackgroundStatesDifference,
                 animated: Bool,
                 screenSignals: ScreenSignals?) {
        if let screenSignals = screenSignals {
            switch screenSignals {
            case .requestFilesInitialPositions:
                backgroundManager.presentFilesInitialPositions()
            case .handleFileElementSelection(let filePath):
                backgroundManager.handleFilePathSelection(filePath: filePath)
            case .handleFilesInitialPositionsSave(let filesInitialPositions):
                backgroundManager.handleFilePathsSave(
                    filesInitialPositions: filesInitialPositions)
            default:
                break
            }
        }
    }
    
}
