//
//  UserInterfaceStatesDifferenceApplier.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/6/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

final class UserInterfaceStatesDifferenceApplier {
    
    private unowned let userInterface: UserInterface
    
    init(userInterface: UserInterface) {
        self.userInterface = userInterface
    }
    
    func applier(statesDifference: UserInterfaceStatesDifference,
                 animated: Bool,
                 screenSignals: ScreenSignals?,
                 completionHandler: @escaping () -> ()) {
        userInterface.userInterfaceStatesDifferenceHandler(
            userInterfaceStatesDifference: statesDifference,
            animated: animated,
            screenSignals: screenSignals,
            completionHandler: completionHandler)
    }
    
}
