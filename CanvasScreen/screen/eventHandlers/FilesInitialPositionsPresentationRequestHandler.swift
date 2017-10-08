//
//  FilesInitialPositionsPresentationRequestHandler.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/6/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import StateManager
import Foundation

func filesMaybeInitialPositionsPresentationRequestHandler(
    state: ScreenState?, event: ScreenEvent) ->
    [StateChangeRequest<ScreenState, ScreenSignals>] {
        if case .filesMaybeInitialPositionsPresentationRequest(
            let filesMaybeInitialPositions) = event {
            enum Direction : Int {
                case west = 0
                case southWest = 1
                case south = 2
                case southEast = 3
                case east = 4
                case northEast = 5
                case north = 6
                case northWest = 7
            }
            
            func point(forDirection direction: Direction, counter: Int) ->
                Point {
                    let padding = counter > 2 ? 10 : 100
                    let paddingReferent = 20
                    let size = 50
                    let negativeValue = Float(-counter * padding - size)
                    let positiveValue = Float(counter * padding + size)
                    let positiveReferent = Float(counter * paddingReferent + size)
                    let negativeReferent = Float(-counter * paddingReferent - size)
                    let referent = Float(counter % 2 == 0 ? 20 : -20)
                    switch direction {
                    case .west:
                        return Point(x: negativeReferent, y: referent)
                    case .southWest:
                        return Point(x: negativeValue, y: positiveValue)
                    case .south:
                        return Point(x: referent, y: positiveValue)
                    case .southEast:
                        return Point(x: positiveValue, y: positiveValue)
                    case .east:
                        return Point(x: positiveReferent, y: referent)
                    case .northEast:
                        return Point(x: positiveValue, y: negativeValue)
                    case .north:
                        return Point(x: referent, y: negativeValue)
                    case .northWest:
                        return Point(x: negativeValue, y: negativeValue)
                    }
            }
            
            var direction: Direction = .west
            var counter = 0
            
            let filesElements = filesMaybeInitialPositions.enumerated()
                .reduce([Int: FileElement]()) {
                    currentFileElements, indexWithFileMaybeInitialPosition in
                    let (index, fileMaybeInitialPosition) =
                    indexWithFileMaybeInitialPosition
                    
                    let text = (((fileMaybeInitialPosition.filePath as NSString)
                        .lastPathComponent as NSString).deletingPathExtension)
                    
                    let position = fileMaybeInitialPosition.position != nil ?
                        Point(
                            x: fileMaybeInitialPosition.position!.x,
                            y: fileMaybeInitialPosition.position!.y) :
                        point(forDirection: direction, counter: counter)
                    
                    counter += 1
                    var nextDirection = direction.rawValue + 1
                    if nextDirection > 7 {
                        counter += 1
                        nextDirection = 0
                    }
                    direction = Direction(rawValue: nextDirection)!
                    
                    var currentFileElements = currentFileElements
                    currentFileElements[index] = FileElement(
                        filePath: fileMaybeInitialPosition.filePath,
                        text: text,
                        position: position)
                    
                    return currentFileElements
            }
            
            return [StateChangeRequest(
                endState: ScreenState(
                    backgroundState: BackgroundState(),
                    userInterfaceState:
                    UserInterfaceState(filesElements: filesElements)),
                animated: false)]
        }
        
        return []
}
