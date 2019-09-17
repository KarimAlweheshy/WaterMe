//
//  PlantFormSectionViewModel.swift
//  Water Me
//
//  Created by Karim Alweheshy on 09.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

protocol PlantFormSectionViewModel {
    var title: String? { get }
    var cells: [PlantFormCellViewModel] { get }
}
