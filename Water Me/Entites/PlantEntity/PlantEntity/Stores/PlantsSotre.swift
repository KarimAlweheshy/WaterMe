//
//  PlantsSotre.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 11.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation
import Combine

public final class PlantsStore: ObservableObject {
    @Published public var allPlants: [Plant]

    private let userDefaults: UserDefaults

    public init() {
        userDefaults = .standard
        allPlants = [Plant]()
        try? loadFromStore()
    }

    public func insert(new plant: Plant) {
        allPlants.insert(plant, at: 0)
        try? updateStore()
    }

    public func remove(old plant: Plant) {
        guard let index = allPlants.firstIndex(where: { $0.id == plant.id }) else { return }
        allPlants.remove(at: index)
        removeLocalImages(for: plant)
        try? updateStore()
    }

    public func move(oldIndex: Int, newIndex: Int) {
        var plants = allPlants
        let plant = plants.remove(at: oldIndex)
        plants.insert(plant, at: min(allPlants.count - 1, newIndex))
        allPlants = plants
        try? updateStore()
    }

    public func update(plant: Plant) {
        guard let index = allPlants.firstIndex(where: { $0.id == plant.id }) else { return }
        var plants = allPlants
        plants.remove(at: index)
        plants.insert(plant, at: index)
        allPlants = plants
        try? updateStore()
    }
}

// MARK: - Private Methods
extension PlantsStore {
    private func updateStore() throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(allPlants)
        userDefaults.setValue(data, forKey: "my_plants")
    }

    private func loadFromStore() throws {
        guard let data = userDefaults.data(forKey: "my_plants") else { return }
        let decoder = JSONDecoder()
        allPlants = try decoder.decode([Plant].self, from: data)
    }

    private func removeLocalImages(for plant: Plant) {
        let plantImagesStore = PlantImagesStore(plant: plant)
        plantImagesStore.removeAll()
    }
}
