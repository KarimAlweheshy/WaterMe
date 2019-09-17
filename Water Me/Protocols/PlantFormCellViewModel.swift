//
//  PlantFormCellViewModel.swift
//  Water Me
//
//  Created by Karim Alweheshy on 09.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import UIKit

protocol PlantFormCellViewModel {
    var titleText: String? { get }
    var detailsText: String? { get }
    var accessoryType: UITableViewCell.AccessoryType { get }
    var image: UIImage? { get }
}
