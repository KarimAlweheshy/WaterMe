//
//  ReminderOccurrence.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public enum ReminderOccurrence: CustomStringConvertible {
    case daily(UInt)
    case weekly(UInt, [WeekDay])
    case monthly(UInt, MonthlyOccurance)

    public var description: String {
        var result = "every "
        switch self {
        case .daily(let daysIntervalCount):
            if daysIntervalCount == 1 {
                result += "day"
            } else {
                result += "\(daysIntervalCount) days"
            }
        case .weekly(let weeksIntervalCount, let weekDays):
            if weeksIntervalCount == 1 {
                result += "week"
            } else {
                result += "\(weeksIntervalCount) weeks"
            }
            result += " on "
            if weekDays.count == 1 {
                result += weekDays.first!.description
            } else {
                let lastDay = weekDays.last!
                result += weekDays.dropLast()
                    .compactMap { $0.description }
                    .joined(separator: ", ")
                result += " and \(lastDay.description)"
            }
        case .monthly(let monthsIntervalCount, let occurance):
            if monthsIntervalCount == 1 {
                result += "month"
            } else {
                result += "\(monthsIntervalCount) months"
            }
            result += " on the "
            result += occurance.description
        }
        return result
    }
}

public enum WeekDay: String, CustomStringConvertible, CaseIterable {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday

    public var description: String {
        return rawValue.capitalized
    }
}

public enum MonthlyOccurance: CustomStringConvertible {
    case each([Int])
    case onThe(MonthlyEventCount, MonthlyEvent)

    public var description: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        switch self {
        case .each(let monthDays):
            return monthDays
                .compactMap {
                    formatter.string(from: NSNumber(value: $0))
                }
                .joined(separator: ", ")
        case .onThe(let eventCount, let event):
            return "\(eventCount.rawValue) \(event.rawValue)"
        }
    }
}

public enum MonthlyEventCount: String {
    case first = "1st"
    case second = "2nd"
    case third = "3rd"
    case fourth = "4th"
    case fifth = "5th"
    case last = "last"
}

public enum MonthlyEvent: String, CustomStringConvertible {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    case day
    case weekday
    case weekendDay

    public var description: String {
        switch self {
        case .weekday:
            return "weekday"
        case .weekendDay:
            return "weekend day"
        case .day:
            return "day"
        default:
            return rawValue.capitalized
        }
    }
}
