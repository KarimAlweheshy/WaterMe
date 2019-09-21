//
//  UnitVolume+CaseIterable.swift
//  PlantForm
//
//  Created by Karim Alweheshy on 13.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

extension UnitVolume {
    static var allCases: [UnitVolume] {
        return [.liters, .cubicDecimeters, .gallons]
    }
}
