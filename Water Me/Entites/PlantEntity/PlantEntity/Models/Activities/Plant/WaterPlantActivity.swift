//
//  WaterPlantActivity.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 16.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct WaterPlantActivity: Activity, Codable {
    public let logs: [LogEntry]
    public let reminder: Reminder

    public init(logs: [LogEntry], reminder: Reminder) {
        self.logs = logs
        self.reminder = reminder
    }
}
