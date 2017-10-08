//
//  ScreenEvent.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/5/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

enum ScreenEvent: CustomDebugStringConvertible {
    
    case userInterfaceLoaded
    case filesMaybeInitialPositionsPresentationRequest(
        filesMaybeInitialPositions: Set<FileMaybeInitialPosition>)
    case backgroundMagnificationChangeRequest(magnification: Float)
    case backgroundPanned(translation: Point)
    case fileElementPanned(id: Int, translation: Point)
    case fileElementSelected(id: Int)
    case saveRequested
    
    var debugDescription: String {
        switch self {
        case .userInterfaceLoaded:
            return "userInterfaceLoaded"
        case .filesMaybeInitialPositionsPresentationRequest(
            let filesMaybeInitialPositions):
            return "filesMaybeInitialPositionsPresentationRequest(" +
            "\(filesMaybeInitialPositions.count) filesMaybeInitialPositions)"
        case .backgroundMagnificationChangeRequest(let magnification):
            return "backgroundMagnificationChangeRequest(" +
            "magnification: \(magnification))"
        case .backgroundPanned(let translation):
            return "backgroundPanned(translation: \(translation))"
        case .fileElementPanned(let id, let translation):
            return "fileElementPanned(id: \(id), translation: \(translation))"
        case .fileElementSelected(let id):
            return "fileElementSelected(id: \(id))"
        case .saveRequested:
            return "saveRequested"
        }
    }
    
}
