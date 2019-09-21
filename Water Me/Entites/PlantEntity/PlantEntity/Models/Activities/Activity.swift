//
//  Activity.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public protocol Activity: Codable {
    static func typeName() -> String

    var logs: [LogEntry] { get }
    var reminder: Reminder { get }
}

extension Activity {
    public static func typeName() -> String {
        return String(describing: self)
    }
}
