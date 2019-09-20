//
//  PlantListViewModel.swift
//  PlantList
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity
import PlantForm

final class PlantListViewModel: ObservableObject {
    @Published var showsFormView = false
    @Published var isEditable = false
    @Published var plantsStore: PlantsStore

    init(plantsStore: PlantsStore) {
        self.plantsStore = plantsStore
    }

    var cellsCount: Range<Int> {
        0..<plantsStore.allPlants.count
    }

    func plantFormView() -> some View {
        PlantFormView(model: .init(store: self.plantsStore))
    }

    func cell(for index: Int) -> some View {
        PlantListCellFactory().make(plantsStore: plantsStore, plant: plantsStore.allPlants[index])
    }

    func delete(at offsets: IndexSet) {
        offsets
            .compactMap { plantsStore.allPlants[$0] }
            .forEach { plantsStore.remove(old: $0) }
    }

    func move(from sourceIndex: IndexSet, to row: Int) {
        guard let oldIndex = sourceIndex.first else { return }
        plantsStore.move(oldIndex: oldIndex, newIndex: row)
    }

    func showForm() {
        isEditable = false
        showsFormView = true
    }

    func toggleEditing() {
        isEditable.toggle()
    }
}
