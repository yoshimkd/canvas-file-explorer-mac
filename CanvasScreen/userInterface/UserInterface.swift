//
//  UserInterface.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/5/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

protocol UserInterface: class {
    
    func userInterfaceStatesDifferenceHandler(
        userInterfaceStatesDifference: UserInterfaceStatesDifference,
        animated: Bool,
        screenSignals: ScreenSignals?,
        completionHandler: @escaping () -> ())
    
}
