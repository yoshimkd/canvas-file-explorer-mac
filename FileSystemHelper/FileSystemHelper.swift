//
//  FileSystemHelper.swift
//  FileSystemHelper
//
//  Created by Jovan Jovanovski on 10/4/17.
//  Copyright © 2017 Jovan. All rights reserved.
//

import Foundation

public struct FileSystemHelper {
    
    public static func getFiles(
        inFileSystemItems fileSystemItems: [URL]) -> [URL] {
        print("Finding files in file system items: \(fileSystemItems)")
        let files = fileSystemItems.reduce([URL]()) {
            urls, url in
            print("Analyzing file system item: \(url)")
            let isDirectoryURL = url.isDirectoryURL
            print("The file system item is a " +
                (isDirectoryURL ? "directory" : "file"))
            
            if isDirectoryURL {
                if let subURLs = try? FileManager.default.contentsOfDirectory(
                    at: url, includingPropertiesForKeys: nil) {
                    print("Digging deeper")
                    return urls + getFiles(inFileSystemItems: subURLs)
                }
                return urls
            }
            
            if url.pathExtension == "swift" {
                return urls + [url]
            }
            
            return urls
        }
        
        print("Found files: \(files)")
        return files
    }
    
}

private extension URL {
    
    var isDirectoryURL: Bool {
        var isDirectory: ObjCBool = false
        FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
    
}
