//
//  BackgroundMagnificationChangeRequestHandler.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/8/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import StateManager

func backgroundMagnificationChangeRequestHandler(
    state: ScreenState?, event: ScreenEvent) ->
    [StateChangeRequest<ScreenState, ScreenSignals>] {
        if case .backgroundMagnificationChangeRequest(
            let magnification) = event {
            guard let state = state else {
                preconditionFailure()
            }
            
            return [StateChangeRequest(
                endState: state,
                animated: false,
                screenSignals: .handleBackgroundMagnificationChange(
                    magnification: magnification))]
        }
        
        return []
}
