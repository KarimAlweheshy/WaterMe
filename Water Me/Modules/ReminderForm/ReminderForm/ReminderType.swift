//
//  ReminderType.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation
import PlantEntity

enum ReminderType: String, CaseIterable {
    case water = "Watering"
    case trimming = "Trimming"
    case fertilizing = "Fertilizing"
    case move = "Moving"
    case mist = "Misting"
    case other = "Other"

    init(reminder: CareReminder) {
        if reminder is MoveReminder {
            self = .move
        } else if reminder is TrimmingReminder {
            self = .trimming
        } else if reminder is FertilizingReminder {
            self = .fertilizing
        } else if reminder is WateringReminder {
            self = .water
        } else if reminder is MistReminder {
            self = .mist
        } else {
            self = .other
        }
    }
}
