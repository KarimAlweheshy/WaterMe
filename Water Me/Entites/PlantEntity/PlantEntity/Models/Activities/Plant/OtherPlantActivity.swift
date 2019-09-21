//
//  OtherPlantActivity.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 19.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct OtherPlantActivity: Activity, Codable {
    public let logs: [LogEntry]
    public let reminder: Reminder
}
