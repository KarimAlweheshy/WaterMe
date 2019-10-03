//
//  LogEntry.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct LogEntry: Codable {
    public let id: Int
    public let date: Date
    public let log: String

    var imageFileNames = [String]()

    public init(
        id: Int,
        date: Date,
        log: String
    ) {
        self.id = id
        self.date = date
        self.log = log
    }
}
