//
//  CareGuide.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 09.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct CareGuide: Codable {
    public let requirements: CareGuideRequirements
    public let reminders: [CareReminder]

    public init(
        requirements: CareGuideRequirements,
        reminders: [CareReminder]
    ) {
        self.requirements = requirements
        self.reminders = reminders
    }

    enum CodingKeys: String, CodingKey {
        case requirements
        case moveReminder
        case waterReminder
        case trimmingReminder
        case fertilizingReminder
        case mistReminder
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        requirements = try container.decode(CareGuideRequirements.self, forKey: .requirements)
        let moveReminder = try container.decodeIfPresent(MoveReminder.self, forKey: .moveReminder)
        let waterReminder = try container.decodeIfPresent(WateringReminder.self, forKey: .waterReminder)
        let trimmingReminder = try container.decodeIfPresent(TrimmingReminder.self, forKey: .trimmingReminder)
        let fertilizingReminder = try container.decodeIfPresent(FertilizingReminder.self, forKey: .fertilizingReminder)
        let mistReminder = try container.decodeIfPresent(MistReminder.self, forKey: .mistReminder)
        reminders = ([moveReminder, trimmingReminder, waterReminder, fertilizingReminder, mistReminder] as [CareReminder?]).compactMap { $0 }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(requirements, forKey: .requirements)
        try reminders.forEach { try encode(reminder: $0, in: &container) }
    }
}

// MARK: - Private Methods
extension CareGuide {
    private func encode(reminder: CareReminder, in container: inout KeyedEncodingContainer<CareGuide.CodingKeys>) throws {
        if let reminder = reminder as? MoveReminder {
            try container.encode(reminder, forKey: .moveReminder)
        } else if let reminder = reminder as? TrimmingReminder {
            try container.encode(reminder, forKey: .trimmingReminder)
        } else if let reminder = reminder as? FertilizingReminder {
            try container.encode(reminder, forKey: .fertilizingReminder)
        } else if let reminder = reminder as? WateringReminder {
            try container.encode(reminder, forKey: .waterReminder)
        } else if let reminder = reminder as? MistReminder {
            try container.encode(reminder, forKey: .mistReminder)
        }
    }
}
