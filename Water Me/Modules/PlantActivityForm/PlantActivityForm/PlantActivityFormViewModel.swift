//
//  PlantActivityFormViewModel.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation
import Combine
import PlantEntity
import Common
import SwiftUI

final class PlantActivityFormViewModel: ObservableObject {
    @Published var images = [UIImage]()
    @Published var notes = ""
    @Published var category = ActivityCategory.water

    private let activity: Activity?
    private let store: PlantsStore
    private let plant: Plant
    private var cancelableSubs = Set<AnyCancellable>()

    public init(store: PlantsStore, plant: Plant, activity: Activity?) {
        self.activity = activity
        self.store = store
        self.plant = plant
    }

    func save() {
        let logEntry = compileNewLogEntry()
        let initialActivity = findOrCreateActivity()
        let updatedActivity = update(initialActivity, with: logEntry)
        let updatedPlantActivities = update(plant.activities, with: updatedActivity)
        let updatedPlant = update(plant, with: updatedPlantActivities)
        store.update(plant: updatedPlant)
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

    var possibleActivities: [ActivityCategory] {
        let assignedActivitiesTypes = plant.activities.all.compactMap { $0.category }
        var missingCategories = ActivityCategory.allCases.filter { !assignedActivitiesTypes.contains($0) }
        if !missingCategories.contains(.other) {
            missingCategories.append(.other)
        }
        return missingCategories
    }
}

// MARK: - Private Methods
extension PlantActivityFormViewModel {
    private func update(_ plant: Plant, with updatedPlantActivities: PlantActivities) -> Plant {
        var updatedPlant = plant
        updatedPlant.activities = updatedPlantActivities
        return updatedPlant
    }

    private func update(_ plantActivities: PlantActivities, with activity: Activity) -> PlantActivities {
        var updatePlantActivities = plantActivities
        switch activity.category {
        case .water:
            guard let activity = activity as? WaterPlantActivity else { fatalError() }
            updatePlantActivities.water = activity
        case .trimming:
            guard let activity = activity as? TrimPlantActivity else { fatalError() }
            updatePlantActivities.trim = activity
        case .fertilizing:
            guard let activity = activity as? FertilizePlantActivity else { fatalError() }
            updatePlantActivities.fertilize = activity
        case .move:
            guard let activity = activity as? MovePlantActivity else { fatalError() }
            updatePlantActivities.move = activity
        case .mist:
            guard let activity = activity as? MistPlantActivity else { fatalError() }
            updatePlantActivities.mist = activity
        case .other:
            guard let activity = activity as? OtherPlantActivity else { fatalError() }
            var oldOtherActivities = updatePlantActivities.others ?? [OtherPlantActivity]()
            oldOtherActivities.append(activity)
            updatePlantActivities.others = oldOtherActivities
        }
        return updatePlantActivities
    }

    private func update(_ initialActivity: Activity, with logEntry: LogEntry) -> Activity {
        var updatedActivity = initialActivity
        updatedActivity.logs.append(logEntry)
        return updatedActivity
    }

    private func findOrCreateActivity() -> Activity {
        let id = Int.random(in: 0...Int.max)
        switch category {
        case .water:
            return plant.activities.water ?? WaterPlantActivity(id: id, logs: [LogEntry](), reminder: nil)
        case .trimming:
            return plant.activities.trim ?? TrimPlantActivity(id: id, logs: [LogEntry](), reminder: nil)
        case .fertilizing:
            return plant.activities.fertilize ?? FertilizePlantActivity(id: id, logs: [LogEntry](), reminder: nil)
        case .move:
            return plant.activities.move ?? MovePlantActivity(id: id, logs: [LogEntry](), reminder: nil)
        case .mist:
            return plant.activities.mist ?? MistPlantActivity(id: id, logs: [LogEntry](), reminder: nil)
        case .other:
            return activity as? OtherPlantActivity ?? OtherPlantActivity(id: id, logs: [LogEntry](), reminder: nil)
        }
    }

    private func compileNewLogEntry() -> LogEntry {
        let logEntry = LogEntry(id: Int.random(in: 0...Int.max), date: Date(), log: notes)
        let store = LogImagesStore(logEntry: logEntry)
        images.forEach(store.add(image:))
        return store.logEntry
    }
}
