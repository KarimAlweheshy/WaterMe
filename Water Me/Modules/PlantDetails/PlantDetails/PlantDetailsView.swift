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
import ReminderForm

public struct PlantDetailsView: View {
    @EnvironmentObject var plantsStore: PlantsStore
    @State private var showsPlantFormView = false
    @State private var showsReminderFormView = false
    private let plant: Plant

    public init(plant: Plant) {
        self.plant = plant
    }

    public var body: some View {
        VStack {
            Text(plant.nickName)
            addReminder()
        }
        .navigationBarTitle(plant.nickName)
        .navigationBarItems(trailing: editButton())
    }

    private func editButton() -> some View {
        Button(action: showPlantForm) { Text("Edit") }
            .sheet(isPresented: $showsPlantFormView) {
                PlantFormView(model: .init(store: self.plantsStore, plant: self.plant))
            }
    }

    private func addReminder() -> some View {
        Button(action: showReminderForm) { Text("Add Reminder") }
            .sheet(isPresented: $showsReminderFormView) {
                ReminderFormView(model: .init(store: self.plantsStore, plantID: self.plant.id))
            }
    }

    private func showPlantForm() {
        showsPlantFormView = true
    }

    private func showReminderForm() {
        showsReminderFormView = true
    }
}
