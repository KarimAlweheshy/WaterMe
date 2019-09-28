//
//  Plant+Images.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 28.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import UIKit

extension Plant {
    public var images: [UIImage] {
        get {
            imageFilesName.compactMap {
                let plantImagesDirectory = FileManager.default.plantImagesDirectory
                return URL(fileURLWithPath: $0, relativeTo: plantImagesDirectory).path
            }.compactMap(UIImage.init(contentsOfFile:))
        }
        set {
            let plantImagesDirectory = FileManager.default.plantImagesDirectory

            let oldImageURLs = imageFilesName.compactMap { URL(fileURLWithPath: $0, relativeTo: plantImagesDirectory) }
            _ = try? oldImageURLs.compactMap(FileManager.default.removeItem(at:))

            imageFilesName = newValue
                .compactMap { image in image.pngData() }
                .compactMap { data in (data, "\(UUID().uuidString).png") }
                .compactMap { data, fileName in (data, URL(fileURLWithPath: fileName, relativeTo: plantImagesDirectory)) }
                .filter { data, url in
                    FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
                }.compactMap { _ , url in
                    return url.lastPathComponent
                }
        }
    }
}
