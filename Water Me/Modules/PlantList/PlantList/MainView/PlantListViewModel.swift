//
//  PlantListViewModel.swift
//  PlantList
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Combine
import SwiftUI
import PlantEntity
import PlantForm

final class PlantListViewModel: ObservableObject, Identifiable {
    @Published var showsFormView = false
    @Published var isEditing = false
    @Published var plantsStore: PlantsStore
    @Published var cellIDs = [Int]()

    private var cancellableSet: Set<AnyCancellable> = []

    init(plantsStore: PlantsStore) {
        self.plantsStore = plantsStore
        plantsStore.$allPlants
            .map { allPlants in allPlants.compactMap { plant in plant.id } }
            .assign(to: \.cellIDs, on: self)
            .store(in: &cancellableSet)
    }

    func plantFormView() -> some View {
        PlantFormView(model: .init(store: self.plantsStore))
    }

    func cell(for cellID: Int) -> some View {
        guard let plant = plantsStore.allPlants.first(where: { $0.id == cellID }) else { fatalError() }
        return PlantListCellFactory().make(plantsStore: plantsStore, plant: plant, isEditing: _isEditing)
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
        isEditing = false
        showsFormView = true
    }

    func didTapEdit() {
        isEditing.toggle()
    }

    var showsEmptyView: Bool {
        plantsStore.allPlants.isEmpty
    }

    var showsEditNavigationButton: Bool {
        !showsEmptyView && !isEditing
    }

    func didTapTraillingNavigationButton() {
        isEditing ? isEditing.toggle() : showForm() 
    }

    var traillingNavigationButtonTitle: String {
        isEditing ? "Done" : "Add"
    }
}
