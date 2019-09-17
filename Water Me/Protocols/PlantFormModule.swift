//
//  PlantFormModule.swift
//  Water Me
//
//  Created by Karim Alweheshy on 09.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public protocol PlantFormModule {
    var moduleDelegate: PlantFormModuleDelegate? { get set }
}
