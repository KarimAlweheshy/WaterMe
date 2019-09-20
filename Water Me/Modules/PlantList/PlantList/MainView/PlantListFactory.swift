//
//  PlantListFactory.swift
//  PlantList
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity

public struct PlantListViewFactory {
    public init() {}
    
    public func make(plantsStore: PlantsStore) -> some View {
        AnyView(PlantListView(viewModel: .init(plantsStore: plantsStore)))
    }
}
