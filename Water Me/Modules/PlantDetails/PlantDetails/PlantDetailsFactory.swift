//
//  PlantDetailsFactory.swift
//  PlantDetails
//
//  Created by Karim Alweheshy on 21.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity

public struct PlantDetailsFactory {
    public init() {}

    public func make(plantsStore: PlantsStore, plant: Plant) -> some View {
        PlantDetailsView(viewModel: .init(plantsStore: plantsStore, plant: plant))
    }
}
