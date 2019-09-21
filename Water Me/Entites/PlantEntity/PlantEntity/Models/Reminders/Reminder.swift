//
//  Reminder.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct Reminder: Codable {
    public let id: Int
    public let occurrence: Occurrence

    public init(id: Int, occurrence: Occurrence) {
        self.id = id
        self.occurrence = occurrence
    }
}
