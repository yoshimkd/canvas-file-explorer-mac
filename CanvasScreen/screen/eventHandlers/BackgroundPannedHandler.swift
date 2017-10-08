//
//  BackgroundPannedHandler.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/8/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import StateManager

func backgroundPannedHandler(
    state: ScreenState?, event: ScreenEvent) ->
    [StateChangeRequest<ScreenState, ScreenSignals>] {
        if case .backgroundPanned(let translation) = event {
            guard var filesElements =
                state?.userInterfaceState.filesElements else {
                    preconditionFailure()
            }
            
            filesElements.forEach {
                [translation = translation] id, fileElement in
                var fileElement = fileElement
                fileElement.position.x += translation.x * 2
                fileElement.position.y += translation.y * 2
                
                filesElements[id] = fileElement
            }
            
            return [StateChangeRequest(
                endState: ScreenState(
                    backgroundState: BackgroundState(),
                    userInterfaceState:
                    UserInterfaceState(filesElements: filesElements)),
                animated: false)]
        }
        
        return []
}
