//
//  WaterPlantActivityFormViewModel.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation
import Combine
import PlantEntity
import UIKit

final class WaterPlantActivityFormViewModel: ObservableObject {
    @Published var waterUnit: UnitVolume = .liters
    @Published var waterValue: Double = 1
    @Published var lastWattered: Date = Calendar.current.startOfDay(for: Date())
}
