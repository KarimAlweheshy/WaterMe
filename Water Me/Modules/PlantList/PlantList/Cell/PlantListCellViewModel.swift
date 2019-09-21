//
//  PlantListCellViewModel.swift
//  PlantList
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity
import PlantDetails

final class PlantListCellViewModel: ObservableObject {
    @Published var nickName: String
    @Published var isEditing: Bool = false

    private let plantsStore: PlantsStore
    private let plant: Plant

    init(plantsStore: PlantsStore, plant: Plant, isEditing: Published<Bool>) {
        self.plantsStore = plantsStore
        self.plant = plant
        nickName = plant.nickName
        _isEditing = isEditing
    }

    var plantDetailsView: some View {
        PlantDetailsFactory().make(plantsStore: plantsStore, plant: plant)
    }
}
