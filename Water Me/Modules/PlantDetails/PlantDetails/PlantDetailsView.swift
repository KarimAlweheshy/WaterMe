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
    @ObservedObject var viewModel: PlantDetailsViewModel

    public init(viewModel: PlantDetailsViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        VStack {
            Text(viewModel.nickName)
            addReminder()
        }
        .navigationBarTitle(viewModel.nickName)
        .navigationBarItems(trailing: editButton())
    }

    private func editButton() -> some View {
        Button(action: viewModel.showPlantForm) { Text("Edit") }
            .sheet(isPresented: $viewModel.showsPlantFormView) {
                self.viewModel.plantFormView()
            }
    }

    private func addReminder() -> some View {
        Button(action: viewModel.showReminderForm) { Text("Add Activity") }
            .sheet(isPresented: $viewModel.showsReminderFormView) {
                self.viewModel.plantActivityFormView()
            }
    }
}
