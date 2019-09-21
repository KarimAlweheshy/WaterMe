//
//  PlantListView.swift
//  PlantList
//
//  Created by Karim Alweheshy on 10.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantForm
import PlantEntity

struct PlantListView: View {
    @ObservedObject var viewModel: PlantListViewModel

    var body: some View {
        NavigationView {
            mainView()
                .navigationBarTitle(Text("My plants"))
                .navigationBarItems(leading: leadingButton(), trailing: traillingButton())
        }
        .sheet(isPresented: $viewModel.showsFormView, content: viewModel.plantFormView)
    }

    private func mainView() -> some View {
        Group {
            if viewModel.showsEmptyView {
                Text("Add plants to your garden")
            } else {
                List {
                    ForEach(viewModel.cellIDs, id: \.self, content: viewModel.cell(for:))
                        .onMove(perform: viewModel.move)
                        .onDelete(perform: viewModel.delete)
                }
                .listStyle(GroupedListStyle())
                .environment(\.editMode, viewModel.isEditing ? .constant(.active) : .constant(.inactive))
            }
        }
    }

    private func traillingButton() -> some View {
        Button(action: viewModel.didTapTraillingNavigationButton) {
            Text(viewModel.traillingNavigationButtonTitle)
        }
    }

    private func leadingButton() -> some View {
        Group {
            if viewModel.showsEditNavigationButton {
                Button(action: viewModel.didTapEdit) { Text("Edit") }
            }
        }
    }
}
