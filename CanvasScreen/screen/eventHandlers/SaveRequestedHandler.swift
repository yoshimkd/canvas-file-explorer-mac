//
//  SaveRequestedHandler.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/8/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import StateManager

func saveRequestedHandler(
    state: ScreenState?, event: ScreenEvent) ->
    [StateChangeRequest<ScreenState, ScreenSignals>] {
        if case .saveRequested = event {
            guard let state = state else {
                preconditionFailure()
            }
            
            let filesInitialPositions =
                Set(state.userInterfaceState.filesElements.values.map {
                    fileElement in
                    return FileInitialPosition(
                        filePath: fileElement.filePath,
                        position: FileInitialPosition.Point(
                            x: fileElement.position.x,
                            y: fileElement.position.y))
                })
            
            return [StateChangeRequest(
                endState: ScreenState(
                    backgroundState: state.backgroundState,
                    userInterfaceState: state.userInterfaceState),
                animated: false,
                screenSignals: .handleFilesInitialPositionsSave(
                    filesInitialPositions: filesInitialPositions))]
        }
        
        return []
}
