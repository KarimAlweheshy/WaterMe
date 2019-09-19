//
//  OtherReminder.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 19.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct OtherReminder: CareReminder {
    public let id: Int
    public let name: String
    public let occurance: ReminderOccurrence
}
