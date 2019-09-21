//
//  Sunlight.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 09.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public enum Sunlight: String, CaseIterable, Codable {
    case partialShade = "Partial Shade"
    case indoor = "Indoor"
    case outdoor = "Outdoor"
}
