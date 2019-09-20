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
            List {
                ForEach(viewModel.cellsCount, id: \.self) { self.viewModel.cell(for: $0) }
                    .onMove(perform: viewModel.move)
                    .onDelete(perform: viewModel.delete)
            }
            .listStyle(GroupedListStyle())
            .environment(\.editMode, viewModel.isEditable ? .constant(.active) : .constant(.inactive))
            .navigationBarTitle(Text("My plants"))
            .navigationBarItems(leading: editButton(), trailing: addButton())
        }
        .sheet(isPresented: $viewModel.showsFormView, content: viewModel.plantFormView)
    }

    private func addButton() -> some View {
        Button(action: viewModel.showForm) { Text("Add") }
    }

    private func editButton() -> some View {
        Button(action: viewModel.toggleEditing) { Text("Edit") }
    }
}
