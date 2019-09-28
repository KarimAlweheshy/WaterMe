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
        var documentsURL = urls(for: .documentDirectory, in: .userDomainMask)[0]
        documentsURL.appendPathComponent("plants", isDirectory: true)
        documentsURL.appendPathComponent("images", isDirectory: true)
        try! createDirectory(at: documentsURL, withIntermediateDirectories: true, attributes: nil)
        return documentsURL
    }
}
