//
//  UserInterfaceLoadedHandler.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/5/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import StateManager

func userInterfaceLoadedHandler(
    state: ScreenState?, event: ScreenEvent) ->
    [StateChangeRequest<ScreenState, ScreenSignals>] {
        if case .userInterfaceLoaded = event {
            precondition(state == nil)
            
            return [StateChangeRequest(
                endState: ScreenState(
                    backgroundState: BackgroundState(),
                    userInterfaceState: UserInterfaceState()),
                animated: false,
                screenSignals: .requestFilesInitialPositions)]
        }
        
        return []
}
