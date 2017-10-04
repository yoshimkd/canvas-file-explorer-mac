//
//  SavedFilesInitialPositionsProvider.swift
//  FilesInitialPositionsProvider
//
//  Created by Jovan Jovanovski on 10/4/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Foundation

public struct SavedFilesInitialPositionsProvider {
    
    public static func savedFilesInitialPositions()
        -> [FileInitialPosition] {
        let documentsDirectoryURL = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)[0]
        let filePathsPositionsFileURL = documentsDirectoryURL
            .appendingPathComponent("filePathsPositions.json")
        
        do {
            let data = try Data(contentsOf: filePathsPositionsFileURL)
            let jsonArray = try JSONSerialization.jsonObject(
                with: data, options: .mutableContainers) as! [[String: Any]]
            return jsonArray.map {
                dictionary in
                let filePath = dictionary["filePath"] as! String
                let position = dictionary["position"] as! [String: CGFloat]
                
                return FileInitialPosition(
                    filePath: filePath,
                    point: CGPoint(x: position["x"]!, y: position["y"]!))
            }
        } catch {
            return []
        }
    }
    
}
