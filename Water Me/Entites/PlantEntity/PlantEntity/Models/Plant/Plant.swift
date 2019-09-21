//
//  Plant.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 09.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct Plant: Identifiable, Codable {
    public let id: Int
    public let nickName: String
    public let botanicalName: String?
    public let imagesURL: [URL]
    public let sunlight: Sunlight
    public let soil: Soil
    public let activities: PlantActivities

    public init(
        id: Int,
        nickName: String,
        botanicalName: String,
        imagesURL: [URL],
        sunlight: Sunlight,
        soil: Soil,
        activities: PlantActivities
    ) {
        self.id = id
        self.nickName = nickName
        self.botanicalName = botanicalName
        self.imagesURL = imagesURL
        self.soil = soil
        self.sunlight = sunlight
        self.activities = activities
    }
}
