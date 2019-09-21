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
    enum Frequency: String, CaseIterable {
        case daily = "Daily"
        case weekly = "Weekly"
    }

    @Published var frequency: Frequency = .daily
    @Published var weekDays: [WeekDay] = [.monday]
    @Published var every: UInt = 1
    @Published var occurrence: Occurrence = .daily(1)

    init(occurrence: Published<Occurrence>) {
        _occurrence = occurrence
        switch self.occurrence {
        case .daily(let every):
            frequency = .daily
            self.every = every
            self.weekDays = [.monday]
        case .weekly(let every, let weekDays):
            frequency = .weekly
            self.weekDays = weekDays
            self.every = every
        }
    }
}

// MARK: - Public Methods
extension ReminderFormViewModel {
    var occurancePublisher: AnyPublisher<Occurrence, Never> {
        Publishers.CombineLatest3($frequency, $weekDays, $every)
            .compactMap(occurance)
            .eraseToAnyPublisher()
    }
}

// MARK: - Internal Methods
extension ReminderFormViewModel {
    var description: String {
        let occurance = self.occurance(frequency: frequency, weekDays: weekDays, every: every)
        return occurance.description.firstCapitalized
    }

    var frequencyDescription: String {
        switch frequency {
        case .daily:
            return every == 1 ? "day" : "\(every) days"
        case .weekly:
            return every == 1 ? "week" : "\(every) weeks"
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

// MARK: - Private Methods
extension ReminderFormViewModel {
    private func occurance(frequency: Frequency, weekDays: [WeekDay], every: UInt) -> Occurrence {
        let occurance: Occurrence
        switch frequency {
        case .daily:
            occurance = .daily(every)
        case .weekly:
            occurance = .weekly(every, weekDays)
        }
        return occurance
    }
}
