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

public struct PlantListView: View {
    @EnvironmentObject var plantsStore: PlantsStore
    @State private var showsFormView = false
    @State private var isEditable = false

    public init() {}

    public var body: some View {
        NavigationView {
            List {
                ForEach(plantsStore.allPlants, id: \.id) {
                    PlantListCellView(plant: $0).environmentObject(self.plantsStore)
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
            }
            .listStyle(GroupedListStyle())
            .environment(\.editMode, isEditable ? .constant(.active) : .constant(.inactive))
            .navigationBarTitle(Text("My plants"))
            .navigationBarItems(leading: editButton(), trailing: addButton())
        }
        .sheet(isPresented: $showsFormView) {
            PlantFormView(model: .init(store: self.plantsStore))
        }
    }

    private func delete(at offsets: IndexSet) {
        offsets
            .compactMap { plantsStore.allPlants[$0] }
            .forEach { plantsStore.remove(old: $0) }
    }

    private func move(from sourceIndex: IndexSet, to row: Int) {
        guard let oldIndex = sourceIndex.first else { return }
        plantsStore.move(oldIndex: oldIndex, newIndex: row)
    }

    private func addButton() -> some View {
        Button(action: showForm) { Text("Add") }
    }

    private func editButton() -> some View {
        Button(action: { self.isEditable.toggle() }) { Text("Edit") }
    }

    private func showForm() {
        isEditable = false
        showsFormView = true
    }
}
