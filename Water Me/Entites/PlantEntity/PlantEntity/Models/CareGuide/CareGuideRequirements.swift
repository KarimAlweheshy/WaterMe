//
//  CareGuideRequirements.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 16.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct CareGuideRequirements: Codable {
    public let sunlight: Sunlight
    public let soil: Soil

    public init(
        sunlight: Sunlight,
        soil: Soil
    ) {
        self.sunlight = sunlight
        self.soil = soil
    }
}
