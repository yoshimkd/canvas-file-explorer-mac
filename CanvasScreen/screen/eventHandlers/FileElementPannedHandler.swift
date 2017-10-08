//
//  FileElementPannedHandler.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/8/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import StateManager

func fileElementPannedHandler(
    state: ScreenState?, event: ScreenEvent) ->
    [StateChangeRequest<ScreenState, ScreenSignals>] {
        if case .fileElementPanned(let id, let translation) = event {
            guard var filesElements =
                state?.userInterfaceState.filesElements else {
                    preconditionFailure()
            }
            
            let position = filesElements[id]!.position
            filesElements[id]!.position = Point(
                x: position.x + translation.x,
                y: position.y + translation.y)
            
            return [StateChangeRequest(
                endState: ScreenState(
                    backgroundState: BackgroundState(),
                    userInterfaceState:
                    UserInterfaceState(filesElements: filesElements)),
                animated: false)]
        }
        
        return []
}
