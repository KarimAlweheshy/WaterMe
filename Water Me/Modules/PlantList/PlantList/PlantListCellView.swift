//
//  PlantListCellView.swift
//  PlantList
//
//  Created by Karim Alweheshy on 10.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity
import PlantDetails

struct PlantListCellView: View {
    @EnvironmentObject var plantsStore: PlantsStore
    let plant: Plant

    var body: some View {
        NavigationLink(destination: PlantDetailsView(plant: plant).environmentObject(plantsStore)) {
            Text(plant.nickName)
        }
    }
}
