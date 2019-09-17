//
//  ReminderFormModel.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Combine
import PlantEntity
import UIKit

public final class ReminderFormModel: ObservableObject {
    private let store: PlantsStore
    private let plantID: Int
    private let reminderID: Int?

    @Published var type: ReminderType
    @Published var images = [UIImage]()
    @Published var reminderOccurance: ReminderOccurrence
    @Published var notes = ""

    public init(store: PlantsStore, plantID: Int, reminder: CareReminder? = nil) {
        self.store = store
        self.plantID = plantID
        reminderID = reminder?.id
        reminderOccurance = .daily(1)
        if let reminder = reminder {
            type = ReminderType(reminder: reminder)
        } else {
            type = .water
        }
    }

    func save() {

    }
}
