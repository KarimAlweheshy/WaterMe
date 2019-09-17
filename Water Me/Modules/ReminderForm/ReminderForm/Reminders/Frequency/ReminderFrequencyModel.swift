//
//  ReminderFrequencyModel.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation
import Combine
import PlantEntity
import Common

final class ReminderFrequencyModel: ObservableObject {
    enum Frequency: String, CaseIterable {
        case daily = "Daily"
        case weekly = "Weekly"
        case monthly = "Monthly"
    }

    @Published var frequency: Frequency = .daily
    @Published var weekDays: [WeekDay] = [.monday]
    @Published var every: UInt = 1
    
    var description: String {
        let occurance: ReminderOccurrence
        switch frequency {
        case .daily:
            occurance = .daily(every)
        case .weekly:
            occurance = .weekly(every, weekDays)
        case .monthly:
            occurance = .monthly(every, MonthlyOccurance.each([1, 2]))
        }
        return occurance.description.firstCapitalized
    }

    var frequencyDescription: String {
        switch frequency {
        case .daily:
            return every == 1 ? "day" : "\(every) days"
        case .weekly:
            return every == 1 ? "week" : "\(every) weeks"
        case .monthly:
            return every == 1 ? "month" : "\(every) months"
        }
    }

    func isSelected(_ weekDay: WeekDay) -> Bool {
        weekDays.contains(weekDay)
    }

    func toggleSelection(for weekDay: WeekDay) {
        if let index = weekDays.firstIndex(of: weekDay) {
            guard weekDays.count > 1 else { return }
            weekDays.remove(at: index)
        } else {
            weekDays.append(weekDay)
        }
    }
}

