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
    @Published var type: ReminderType
    @Published var images = [UIImage]()
    @Published var reminderOccurance: ReminderOccurrence
    @Published var notes = ""
    
    private let store: PlantsStore
    private let plantID: Int
    private let reminderID: Int?
    private var cancelableSubs = Set<AnyCancellable>()

    var subs = Set<AnyCancellable>()
    lazy var reminderFrequencyModel: ReminderFrequencyViewModel = {
        let model = ReminderFrequencyViewModel(occurance: reminderOccurance)
        model.occurancePublisher
            .assign(to: \.reminderOccurance, on: self)
            .store(in: &subs)
        return model
    }()

    public init(store: PlantsStore, plantID: Int, reminder: CareReminder? = nil) {
        self.store = store
        self.plantID = plantID
        reminderID = reminder?.id
        reminderOccurance = reminder?.occurance ?? .daily(1)
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
