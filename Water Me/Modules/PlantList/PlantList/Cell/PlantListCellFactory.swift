//
//  PlantListCellFactory.swift
//  PlantList
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity

struct PlantListCellFactory {
    func make(plantsStore: PlantsStore, plant: Plant) -> some View {
        PlantListCellView(viewModel: .init(plantsStore: plantsStore, plant: plant))
    }
}
