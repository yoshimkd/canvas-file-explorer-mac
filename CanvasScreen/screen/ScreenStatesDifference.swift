//
//  ScreenStatesDifference.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/5/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

struct ScreenStatesDifference {
    
    let backgroundStatesDifference: BackgroundStatesDifference
    let userInterfaceStatesDifference: UserInterfaceStatesDifference
    
    init(startState: ScreenState?, endState: ScreenState) {
        backgroundStatesDifference = BackgroundStatesDifference(
            startState: startState?.backgroundState,
            endState: endState.backgroundState)
        userInterfaceStatesDifference = UserInterfaceStatesDifference(
            startState: startState?.userInterfaceState,
            endState: endState.userInterfaceState)
    }
    
}
