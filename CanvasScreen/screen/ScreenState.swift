//
//  ScreenState.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/5/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

struct ScreenState {
    
    var backgroundState: BackgroundState
    var userInterfaceState: UserInterfaceState
    
    init(backgroundState: BackgroundState,
         userInterfaceState: UserInterfaceState) {
        self.backgroundState = backgroundState
        self.userInterfaceState = userInterfaceState
    }
    
}
