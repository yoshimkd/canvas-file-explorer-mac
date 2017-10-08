//
//  FilesInitialPositionsCache.swift
//  FilesInitialPositionsProvider
//
//  Created by Jovan Jovanovski on 10/4/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Foundation

public struct FilesInitialPositionsCache {
    
    private static var filePathsPositionsFile: URL {
        let documentsDirectory = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask)[0]
        return documentsDirectory
            .appendingPathComponent("filePathsPositions.json")
    }
    
    public static func savedFilesInitialPositions()
        -> Set<FileInitialPosition> {
            do {
                let data = try Data(contentsOf: filePathsPositionsFile)
                let jsonArray = try JSONSerialization.jsonObject(
                    with: data, options: .mutableContainers) as! [[String: Any]]
                return Set(jsonArray.map {
                    dictionary in
                    let filePath = dictionary["filePath"] as! String
                    let position = dictionary["position"] as! [String: Float]
                    
                    return FileInitialPosition(
                        filePath: filePath,
                        position: FileInitialPosition.Point(
                            x: position["x"]!, y: position["y"]!))
                })
            } catch {
                return []
            }
    }
    
    public static func save(filesInitialPositions: Set<FileInitialPosition>) {
        let dictionary =
            filesInitialPositions.map {
                fileInitialPosition -> [String : Any] in
                return ["filePath": fileInitialPosition.filePath,
                        "position": ["x": fileInitialPosition.position.x,
                                     "y": fileInitialPosition.position.y]]
        }
        
        let data = try! JSONSerialization.data(withJSONObject: dictionary)
        let json = String(data: data, encoding: .utf8)!
        try! json.write(
            to: filePathsPositionsFile, atomically: true, encoding: .utf8)
    }
    
}
