//
//  FileManager+Entity.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 28.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

extension FileManager {
    var plantImagesDirectory: URL {
        var documentsURL = imagesDirectory
        documentsURL.appendPathComponent("plants", isDirectory: true)
        try! createDirectory(at: documentsURL, withIntermediateDirectories: true, attributes: nil)
        return documentsURL
    }

    var logImagesDirectory: URL {
        var documentsURL = imagesDirectory
        documentsURL.appendPathComponent("logs", isDirectory: true)
        try! createDirectory(at: documentsURL, withIntermediateDirectories: true, attributes: nil)
        return documentsURL
    }

    var imagesDirectory: URL {
        var documentsURL = urls(for: .documentDirectory, in: .userDomainMask)[0]
        documentsURL.appendPathComponent("images", isDirectory: true)
        try! createDirectory(at: documentsURL, withIntermediateDirectories: true, attributes: nil)
        return documentsURL
    }
}
