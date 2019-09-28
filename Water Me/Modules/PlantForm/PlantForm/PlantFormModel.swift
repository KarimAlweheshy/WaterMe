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
        images = plant.map(PlantImagesStore.init(plant:)).map { $0.images } ?? [UIImage]()
    }

    func save() {
        let plant = Plant(id: id ?? Int.random(in: 0...Int.max),
                          nickName: nickName,
                          botanicalName: botanicalName,
                          sunlight: sunlight,
                          soil: soil,
                          activities: .init())
        let imagesStore = PlantImagesStore(plant: plant)
        images.forEach(imagesStore.add(image:))

        if id != nil {
            store.update(plant: imagesStore.plant)
        } else {
            store.insert(new: imagesStore.plant)
        }
    }

    lazy var pickImagesModel: PickImagesViewModel = {
        let model = PickImagesViewModel()
        model.publisher.sink { image in
            guard let image = image else { return }
            self.images.insert(image, at: 0)
        }
        .store(in: &cancelableSubs)
        return model
    }()
}
