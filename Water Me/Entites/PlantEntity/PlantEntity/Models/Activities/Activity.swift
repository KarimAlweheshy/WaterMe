//
//  Activity.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public protocol Activity: Codable {
    var id: Int { get }
    var category: ActivityCategory { get }
    var logs: [LogEntry] { get set }
    var reminder: Reminder? { get set }
}

public enum ActivityCategory: String, Codable, CaseIterable {
    case water = "Watering"
    case trimming = "Trimming"
    case fertilizing = "Fertilizing"
    case move = "Moving"
    case mist = "Misting"
    case other = "Other"
}
