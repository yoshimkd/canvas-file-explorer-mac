//
//  StateChangeRequest.swift
//  StateManager
//
//  Created by Jovan Jovanovski on 10/7/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

public struct StateChangeRequest<S: State, SS> {
    
    let endState: S
    let animated: Bool
    let screenSignals: SS?
    
    public init(endState: S,
                animated: Bool,
                screenSignals: SS? = nil) {
        self.endState = endState
        self.animated = animated
        self.screenSignals = screenSignals
    }
    
}
