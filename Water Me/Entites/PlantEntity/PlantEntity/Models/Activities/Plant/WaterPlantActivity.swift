//
//  WaterPlantActivity.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 16.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct WaterPlantActivity: Activity, Codable {
    public let id: Int
    public let category = ActivityCategory.water
    public var logs: [LogEntry]
    public var reminder: Reminder?

    public init(id: Int, logs: [LogEntry], reminder: Reminder?) {
        self.id = id
        self.logs = logs
        self.reminder = reminder
    }
}
