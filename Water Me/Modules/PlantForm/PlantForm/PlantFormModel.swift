//
//  PlantFormModel.swift
//  PlantForm
//
//  Created by Karim Alweheshy on 15.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Combine
import PlantEntity
import UIKit

public final class PlantFormModel: ObservableObject {
    @Published var nickName: String
    @Published var botanicalName: String
    @Published var soil: Soil
    @Published var sunlight: Sunlight
    @Published var waterUnit: UnitVolume
    @Published var waterValue: Double
    @Published var images: [UIImage]

    private let store: PlantsStore
    private let id: Int?

    public init(store: PlantsStore, plant: Plant? = nil) {
        self.store = store
        id = plant?.id
        nickName = plant?.nickName ?? ""
        botanicalName = plant?.botanicalName ?? ""
        soil = plant?.careGuide.requirements.soil ?? .neutral
        sunlight = plant?.careGuide.requirements.sunlight ?? .partialShade
        waterUnit = plant?.careGuide.requirements.water.unit ?? .liters
        waterValue = plant?.careGuide.requirements.water.value ?? 1
        images = plant?.imagesURL.compactMap { UIImage(contentsOfFile: $0.path) } ?? [UIImage]()
    }

    func save() {
        let requirements = CareGuideRequirements(water: Measurement(value: waterValue,
                                                                    unit: waterUnit),
                                                 sunlight: sunlight,
                                                 soil: soil)
        let careGuide = CareGuide(requirements: requirements, reminders: [CareReminder]())
        let plant = Plant(id: id ?? Int.random(in: 0...Int.max),
                          nickName: nickName,
                          botanicalName: botanicalName,
                          imagesURL: imageURLs(for: images),
                          careGuide: careGuide)

        if let id = id, let oldPlant = store.allPlants.first(where: { $0.id == id }) {
            store.update(old: oldPlant, new: plant)
        } else {
            store.insert(new: plant)
        }
    }
}

// MARK: - Private Methods
extension PlantFormModel {
    private func imageURLs(for images: [UIImage]) -> [URL] {
        let fileManager = FileManager.default
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return images.compactMap { image in
            var url = documentsURL
            url.appendPathComponent("plants", isDirectory: true)
            url.appendPathComponent("images", isDirectory: true)
            try! fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            url.appendPathComponent("\(UUID().uuidString).png")
            let data = image.pngData()!
            fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
            return url
        }
    }
}
