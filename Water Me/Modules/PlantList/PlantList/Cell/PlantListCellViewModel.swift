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

    private let plantsStore: PlantsStore
    private let plant: Plant

    init(plantsStore: PlantsStore, plant: Plant) {
        self.plantsStore = plantsStore
        self.plant = plant
        nickName = plant.nickName
    }

    var plantDetailsView: some View {
        PlantDetailsView(viewModel: .init(plantsStore: plantsStore, plant: plant))
    }
}
