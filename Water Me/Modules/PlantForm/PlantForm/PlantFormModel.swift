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
import Common

public final class PlantFormModel: ObservableObject {
    @Published var nickName: String
    @Published var botanicalName: String
    @Published var soil: Soil
    @Published var sunlight: Sunlight
    @Published var images: [UIImage]

    private let store: PlantsStore
    private let id: Int?
    private var cancelableSubs = Set<AnyCancellable>()

    public init(store: PlantsStore, plant: Plant? = nil) {
        self.store = store
        id = plant?.id
        nickName = plant?.nickName ?? ""
        botanicalName = plant?.botanicalName ?? ""
        soil = plant?.soil ?? .neutral
        sunlight = plant?.sunlight ?? .partialShade
        images = plant?.images ?? [UIImage]()
    }

    func save() {
        var plant = Plant(id: id ?? Int.random(in: 0...Int.max),
                          nickName: nickName,
                          botanicalName: botanicalName,
                          sunlight: sunlight,
                          soil: soil,
                          activities: .init())
        plant.images = images

        if let id = id, let oldPlant = store.allPlants.first(where: { $0.id == id }) {
            store.update(old: oldPlant, new: plant)
        } else {
            store.insert(new: plant)
        }
    }

    lazy var pickImagesModel: PickImagesModel = {
        let model = PickImagesModel(title: "Pick", images: images)
        model.publisher.assign(to: \.images, on: self).store(in: &cancelableSubs)
        return model
    }()
}
