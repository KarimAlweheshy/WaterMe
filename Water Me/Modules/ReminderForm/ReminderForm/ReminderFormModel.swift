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

    public init(store: PlantsStore, plantID: Int, reminder: CareReminder? = nil) {
        self.store = store
        self.plantID = plantID
        reminderID = reminder?.id
    }

    func save() {

    }
}
