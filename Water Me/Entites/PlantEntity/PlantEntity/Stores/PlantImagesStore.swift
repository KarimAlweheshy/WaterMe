//
//  Plant+Images.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 28.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Combine
import SwiftUI

public final class PlantImagesStore: ObservableObject {
    @Published public var plant: Plant
    @Published public var images = [UIImage]()

    private var cancellables = Set<AnyCancellable>()

    public init(plant: Plant) {
        self.plant = plant
        $plant
            .compactMap {
                let fileNames = $0.imageFilesName
                let plantImagesDirectory = FileManager.default.plantImagesDirectory
                let urls = fileNames.compactMap { URL(fileURLWithPath: $0, relativeTo: plantImagesDirectory).path }
                return urls.compactMap(UIImage.init(contentsOfFile:))
            }
            .assign(to: \.images, on: self)
            .store(in: &cancellables)
    }

    public func removeAll() {
        plant.imageFilesName.removeAll()
    }

    public func remove(image: UIImage) {
        guard let index = images.firstIndex(of: image) else { return }
        plant.imageFilesName.remove(at: index)
    }

    public func add(image: UIImage) {
        let plantImagesDirectory = FileManager.default.plantImagesDirectory

        guard
            let entry = image.pngData()
                .map({ data in (data, "\(UUID().uuidString).png") })
                .map({ data, fileName in (data, URL(fileURLWithPath: fileName, relativeTo: plantImagesDirectory)) }),
            FileManager.default.createFile(atPath: entry.1.path, contents: entry.0, attributes: nil)
        else {
            return
        }

        let fileName = entry.1.lastPathComponent
        plant.imageFilesName.insert(fileName, at: 0)
    }
}
