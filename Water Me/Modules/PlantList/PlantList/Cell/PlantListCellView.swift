//
//  PlantListCellView.swift
//  PlantList
//
//  Created by Karim Alweheshy on 10.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity
import PlantDetails

struct PlantListCellView: View {
    @ObservedObject var viewModel: PlantListCellViewModel

    var body: some View {
        NavigationLink(destination: viewModel.plantDetailsView) {
            Text(viewModel.nickName)
        }
    }
}
