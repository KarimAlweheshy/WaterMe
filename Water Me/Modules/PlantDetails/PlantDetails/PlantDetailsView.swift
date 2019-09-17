//
//  PlantDetailsView.swift
//  PlantDetails
//
//  Created by Karim Alweheshy on 11.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity
import PlantForm

public struct PlantDetailsView: View {
    @EnvironmentObject var plantsStore: PlantsStore
    @State private var showsFormView = false
    private let plant: Plant

    public init(plant: Plant) {
        self.plant = plant
    }

    public var body: some View {
        Text(plant.nickName)
            .navigationBarTitle(plant.nickName)
            .navigationBarItems(trailing: editButton())
            .sheet(isPresented: $showsFormView) {
                PlantFormView(model: .init(store: self.plantsStore, plant: self.plant))
        }
    }

    private func editButton() -> some View {
        Button(action: showForm) { Text("Edit") }
    }

    private func showForm() {
        showsFormView = true
    }
}
