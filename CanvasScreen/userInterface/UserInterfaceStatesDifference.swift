//
//  UserInterfaceStatesDifference.swift
//  CanvasScreen
//
//  Created by Jovan Jovanovski on 10/5/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

struct UserInterfaceStatesDifference {
    
    let newFilesElements: [Int: FileElement]
    let editedFilesElements: [Int: FileElement]
    
    init(startState: UserInterfaceState?, endState: UserInterfaceState) {
        if let startState = startState {
            (newFilesElements, editedFilesElements) =
                endState.filesElements.reduce(
                ([Int: FileElement](), [Int: FileElement]())) {
                    currentNewFilesElementsAndEditedFilesElements,
                    idWithFileElement in
                    var (currentNewFilesElements,
                        currentEditedFilesElements) =
                    currentNewFilesElementsAndEditedFilesElements
                    let (id, fileElement) = idWithFileElement
                    
                    if let startFileElement = startState.filesElements[id] {
                        if fileElement.position != startFileElement.position {
                            currentEditedFilesElements[id] = fileElement
                        }
                    } else {
                        currentNewFilesElements[id] = fileElement
                    }
                    
                    return (currentNewFilesElements,
                            currentEditedFilesElements)
            }
        } else {
            newFilesElements = endState.filesElements
            editedFilesElements = [Int: FileElement]()
        }
    }
    
}
