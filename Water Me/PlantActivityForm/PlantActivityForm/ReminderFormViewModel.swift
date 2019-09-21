//
//  ReminderFormViewModel.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Combine
import PlantEntity
import UIKit
import Common

public final class ReminderFormViewModel: ObservableObject {
    @Published var activity: Activity
    @Published var images = [UIImage]()
    @Published var occurrence: Occurrence
    @Published var notes = ""
    
    private let store: PlantsStore
    private let plantID: Int
    private let reminderID: Int?
    private var cancelableSubs = Set<AnyCancellable>()

    var subs = Set<AnyCancellable>()
    lazy var reminderFrequencyModel: ReminderFrequencyViewModel = {
        let model = ReminderFrequencyViewModel(occurrence: occurrence)
        model.occurancePublisher
            .assign(to: \.occurrence, on: self)
            .store(in: &subs)
        return model
    }()

    public init(store: PlantsStore, plantID: Int, reminder: Reminder? = nil) {
        self.store = store
        self.plantID = plantID
        reminderID = reminder?.id
        occurrence = reminder?.occurrence ?? .daily(1)
        if let reminder = reminder {
            type = ReminderType(reminder: reminder)
        } else {
            type = .water
        }
    }

    func save() {

    }

    lazy var pickImagesModel: PickImagesModel = {
        let model = PickImagesModel(title: "Pick", images: images)
        model.publisher.assign(to: \.images, on: self).store(in: &cancelableSubs)
        return model
    }()
}
