//
//  PlantDetailsViewModel.swift
//  PlantDetails
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import Combine
import PlantEntity
import PlantForm
import PlantActivityForm

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

    func plantFormView() -> some View {
        PlantFormView(model: .init(store: plantsStore, plant: plant))
    }

    func plantActivityFormView() -> some View {
        let reminder = Reminder(
            id: Int.random(in: 0...Int.max),
            occurrence: .daily(1)
        )
        let activity = WaterPlantActivity(
            logs: [LogEntry](),
            reminder: reminder
        )
        return PlantActivityFormFactory().make(
            store: plantsStore,
            plantID: plant.id,
            activity: activity
        )
    }

    func showPlantForm() {
        showsPlantFormView = true
    }

    func showReminderForm() {
        showsReminderFormView = true
    }
}
