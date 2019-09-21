//
//  PlantActivities.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct PlantActivities: Codable {
    public enum Category: String, CaseIterable {
        case water = "Watering"
        case trimming = "Trimming"
        case fertilizing = "Fertilizing"
        case move = "Moving"
        case mist = "Misting"
        case other = "Other"
    }

    public let move: MovePlantActivity?
    public let fertilize: FertilizePlantActivity?
    public let mist: MistPlantActivity?
    public let trim: TrimPlantActivity?
    public let water: WaterPlantActivity?
    public let others: [OtherPlantActivity]?

    public init(
        move: MovePlantActivity? = nil,
        fertilize: FertilizePlantActivity? = nil,
        mist: MistPlantActivity? = nil,
        trim: TrimPlantActivity? = nil,
        water: WaterPlantActivity? = nil,
        others: [OtherPlantActivity]? = nil
    ) {
        self.move = move
        self.fertilize = fertilize
        self.mist = mist
        self.trim = trim
        self.water = water
        self.others = others
    }
}
