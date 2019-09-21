//
//  Soil.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 09.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public enum Soil: String, CaseIterable, Codable {
    case chalky = "Chalky"
    case loam = "Loam"
    case clay = "Clay"
    case sand = "Sand"
    case wellDrained = "Well Drained"
    case slightlyAcidic = "Slightly Acidic"
    case neutral = "Neutral"
    case slightlyAlkaline = "Slightly Alkaline"
}
