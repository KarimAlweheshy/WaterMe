//
//  PlantDetailsViewModel.swift
//  PlantDetails
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Combine
import PlantEntity
import PlantForm
import ReminderForm

public final class PlantDetailsViewModel: ObservableObject {
    @Published var showsPlantFormView = false
    @Published var showsReminderFormView = false
    @Published var nickName: String

    private let plantsStore: PlantsStore
    private let plant: Plant

    public init(plantsStore: PlantsStore, plant: Plant) {
        self.plantsStore = plantsStore
        self.plant = plant
        nickName =  plant.nickName
    }

    func plantFormViewModel() -> PlantFormModel {
        .init(store: plantsStore, plant: plant)
    }

    func reminderFormViewModel() -> ReminderFormViewModel {
        .init(store: plantsStore, plantID: plant.id)
    }

    func showPlantForm() {
        showsPlantFormView = true
    }

    func showReminderForm() {
        showsReminderFormView = true
    }
}
