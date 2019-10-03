//
//  LogImagesStore.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 03.10.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Combine
import SwiftUI

public final class LogImagesStore: ObservableObject {
    @Published public var logEntry: LogEntry
    @Published public var images = [UIImage]()

    private var cancellables = Set<AnyCancellable>()

    public init(logEntry: LogEntry) {
        self.logEntry = logEntry
        $logEntry
            .compactMap {
                let fileNames = $0.imageFileNames
                let plantImagesDirectory = FileManager.default.logImagesDirectory
                let urls = fileNames.compactMap { URL(fileURLWithPath: $0, relativeTo: plantImagesDirectory).path }
                return urls.compactMap(UIImage.init(contentsOfFile:))
            }
            .assign(to: \.images, on: self)
            .store(in: &cancellables)
    }

    public func removeAll() {
        logEntry.imageFileNames.removeAll()
    }

    public func remove(image: UIImage) {
        guard let index = images.firstIndex(of: image) else { return }
        logEntry.imageFileNames.remove(at: index)
    }

    public func add(image: UIImage) {
        let plantImagesDirectory = FileManager.default.logImagesDirectory

        guard
            let entry = image.pngData()
                .map({ data in (data, "\(UUID().uuidString).png") })
                .map({ data, fileName in (data, URL(fileURLWithPath: fileName, relativeTo: plantImagesDirectory)) }),
            FileManager.default.createFile(atPath: entry.1.path, contents: entry.0, attributes: nil)
        else {
            return
        }

        let fileName = entry.1.lastPathComponent
        logEntry.imageFileNames.insert(fileName, at: 0)
    }
}

