//
//  FileElementSelectedHandler.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/8/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import StateManager

func fileElementSelectedHandler(
    state: ScreenState?, event: ScreenEvent) ->
    [StateChangeRequest<ScreenState, ScreenSignals>] {
        if case .fileElementSelected(let id) = event {
            guard let state = state else {
                preconditionFailure()
            }
            
            return [StateChangeRequest(
                endState: ScreenState(
                    backgroundState: BackgroundState(),
                    userInterfaceState: state.userInterfaceState),
                animated: false,
                screenSignals: .handleFileElementSelection(filePath:
                    state.userInterfaceState.filesElements[id]!.filePath))]
        }
        
        return []
}
