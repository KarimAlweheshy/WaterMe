//
//  PlantActivityFormViewModel.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation
import Combine
import PlantEntity
import Common
import SwiftUI
import ReminderForm

final class PlantActivityFormViewModel: ObservableObject {
    @Published var images = [UIImage]()
    @Published var occurrence: Occurrence
    @Published var notes = ""
    @Published var category = PlantActivities.Category.water

    private let activity: Activity
    private let store: PlantsStore
    private let plantID: Int
    private var cancelableSubs = Set<AnyCancellable>()

    public init(store: PlantsStore, plantID: Int, activity: Activity) {
        self.activity = activity
        self.store = store
        self.plantID = plantID
        occurrence = activity.reminder.occurrence
    }

    func save() {

    }

    lazy var pickImagesModel: PickImagesModel = {
        let model = PickImagesModel(title: "Pick", images: images)
        model.publisher.assign(to: \.images, on: self).store(in: &cancelableSubs)
        return model
    }()

    func reminderFormView() -> some View {
        ReminderFormFactory().make(occurrence: _occurrence)
    }
}
