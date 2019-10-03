//
//  PlantActivities.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 20.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct PlantActivities: Codable {
    public var move: MovePlantActivity?
    public var fertilize: FertilizePlantActivity?
    public var mist: MistPlantActivity?
    public var trim: TrimPlantActivity?
    public var water: WaterPlantActivity?
    public var others: [OtherPlantActivity]?

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

    public var all: [Activity] {
        var allActivities = ([move, fertilize, mist, trim, water] as [Activity?]).compactMap { $0 }
        others.map { allActivities.append(contentsOf: $0) }
        return allActivities
    }
}
