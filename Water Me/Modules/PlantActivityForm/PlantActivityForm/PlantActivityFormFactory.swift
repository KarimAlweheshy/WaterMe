//
//  PlantActivityFormFactory.swift
//  PlantActivityForm
//
//  Created by Karim Alweheshy on 21.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity

public struct PlantActivityFormFactory {
    public init() {}
    
    public func make(store: PlantsStore, plantID: Int, activity: Activity) -> some View {
        PlantActivityFormView(viewModel: .init(store: store, plantID: plantID, activity: activity))
    }
}
