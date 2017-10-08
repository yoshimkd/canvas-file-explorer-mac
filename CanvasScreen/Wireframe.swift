//
//  Wireframe.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/1/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import AppKit
import StateManager

public final class Wireframe {
    
    private let stateManager: StateManager
    <ScreenState, ScreenEvent, ScreenSignals, ScreenStatesDifference>
    public let viewController: NSViewController
    
    public init(
        filesMaybeInitialPositions: Set<FileMaybeInitialPosition>,
        filePathSelectionHandler: @escaping (String) -> (),
        filesInitialPositionsSaver:
        @escaping (Set<FileInitialPosition>) -> ()) {
        let viewController = ViewController.createFromNib()
        self.viewController = viewController
        
        let backgroundManager = BackgroundManager(
            filesMaybeInitialPositions: filesMaybeInitialPositions,
            filePathSelectionHandler: filePathSelectionHandler,
            filesInitialPositionsSaver: filesInitialPositionsSaver)
        
        let screenStatesDifferenceApplier = ScreenStatesDifferenceApplier(
            userInterface: viewController,
            backgroundManager: backgroundManager)
        
        stateManager = StateManager(
            handlers: [
                userInterfaceLoadedHandler,
                filesMaybeInitialPositionsPresentationRequestHandler,
                backgroundMagnificationChangeRequestHandler,
                backgroundPannedHandler,
                fileElementPannedHandler,
                fileElementSelectedHandler,
                saveRequestedHandler],
            statesDifferenceCreator: ScreenStatesDifference.init,
            applier: screenStatesDifferenceApplier.applier
        )
        stateManager.setup()
        
        viewController.eventHandler = stateManager.handle
        backgroundManager.eventHandler = stateManager.handle
    }
    
}

extension BackgroundManager: BackgroundManagerProtocol {}
extension ViewController: UserInterface {}
extension ScreenState: State {}
extension ScreenEvent: Event {}
extension ScreenStatesDifference: StatesDifference {}
