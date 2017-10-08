//
//  ScreenStatesDifferenceApplier.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/6/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

final class ScreenStatesDifferenceApplier {
    
    private let userInterfaceStatesDifferenceApplier:
    UserInterfaceStatesDifferenceApplier
    private let backgroundStatesDifferenceApplier:
    BackgroundStatesDifferenceApplier
    
    init(userInterface: UserInterface,
         backgroundManager: BackgroundManagerProtocol) {
        self.userInterfaceStatesDifferenceApplier =
            UserInterfaceStatesDifferenceApplier(
                userInterface: userInterface)
        self.backgroundStatesDifferenceApplier =
            BackgroundStatesDifferenceApplier(
                backgroundManager: backgroundManager)
    }
    
    func applier(statesDiffernece: ScreenStatesDifference,
                 animated: Bool,
                 screenSignals: ScreenSignals?,
                 completionHandler: @escaping () -> ()) {
        backgroundStatesDifferenceApplier.applier(
            statesDifference: statesDiffernece.backgroundStatesDifference,
            animated: animated,
            screenSignals: screenSignals)
        userInterfaceStatesDifferenceApplier.applier(
            statesDifference: statesDiffernece.userInterfaceStatesDifference,
            animated: animated,
            screenSignals: screenSignals,
            completionHandler: completionHandler)
    }
    
}
