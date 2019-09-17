//
//  CareGuideRequirements.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 16.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct CareGuideRequirements: Codable {
    public let water: Measurement<UnitVolume>
    public let sunlight: Sunlight
    public let soil: Soil

    public init(
        water: Measurement<UnitVolume>,
        sunlight: Sunlight,
        soil: Soil
    ) {
        self.water = water
        self.sunlight = sunlight
        self.soil = soil
    }
}
