//
//  PlantFormPresenter.swift
//  Water Me
//
//  Created by Karim Alweheshy on 09.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

protocol PlantFormPresenter {
    func numberOfSections() -> Int
    func numberOfRows(in: Int) -> Int

    func didSelectCell(at: IndexPath)
    func title(for section: Int) -> String?
    func cellViewModel(at: IndexPath) -> PlantFormCellViewModel
}
