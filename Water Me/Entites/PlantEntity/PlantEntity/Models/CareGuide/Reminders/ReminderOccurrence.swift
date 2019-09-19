//
//  ReminderOccurrence.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public enum ReminderOccurrence: Codable, CustomStringConvertible {
    case daily(UInt)
    case weekly(UInt, [WeekDay])

    enum CodingKeys: String,  CodingKey {
        case type
        case everyCount
        case weekDays
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(String.self, forKey: .type)
        let everyCount = try container.decode(UInt.self, forKey: .everyCount)
        if type == "daily" {
            self = .daily(everyCount)
        } else if type == "weekly" {
            let weekDayStrings = try container.decode([String].self, forKey: .weekDays)
            self = .weekly(everyCount, weekDayStrings.compactMap { WeekDay(rawValue: $0) } )
        }
        fatalError()
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .daily(let everyCount):
            try container.encode("daily", forKey: .type)
            try container.encode(everyCount, forKey: .everyCount)
        case .weekly(let everyCount, let weekDays):
            try container.encode("weekly", forKey: .type)
            try container.encode(everyCount, forKey: .everyCount)
            try container.encode(weekDays.compactMap { $0.rawValue }, forKey: .weekDays)
        }
    }

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
            let weekDays = weekDays.sorted()
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
        }
        return result
    }
}

public enum WeekDay: String, CustomStringConvertible, CaseIterable, Comparable {
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

    public static func < (lhs: WeekDay, rhs: WeekDay) -> Bool {
        let weekDays = WeekDay.allCases
        let lhsIndex = weekDays.firstIndex(of: lhs)!
        let rhsIndex = weekDays.firstIndex(of: rhs)!
        return lhsIndex < rhsIndex
    }
}
