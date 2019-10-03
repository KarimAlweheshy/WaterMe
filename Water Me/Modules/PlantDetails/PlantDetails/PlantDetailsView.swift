//
//  PlantDetailsView.swift
//  PlantDetails
//
//  Created by Karim Alweheshy on 11.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity
import PlantForm
import Common

struct PlantDetailsView: View {
    @ObservedObject var viewModel: PlantDetailsViewModel

    init(viewModel: PlantDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                self.contentView().padding([.leading])
                self.activities().padding([.leading, .trailing])
                self.addReminder().padding([.leading, .trailing])
                Spacer()
            }
        }
        .navigationBarTitle(viewModel.nickName)
        .navigationBarItems(trailing: editButton())
    }
}

// MARK: - Private Methods
extension PlantDetailsView {
    private func contentView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                PickImagesButton(viewModel: viewModel.pickImagesModel) {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                ForEach(self.viewModel.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 100)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .frame(height: 100)
    }

    private func activities() -> some View {
        Section(header: Text("Activities").font(.headline)) {
            ForEach(ActivityCategory.allCases.dropLast(), id: \.self) {
                Text($0.rawValue).font(.subheadline)
            }
        }
    }
    private func editButton() -> some View {
        Button(action: viewModel.didTapEdit) { Text("Edit") }
            .sheet(isPresented: $viewModel.showsPlantFormView) {
                self.viewModel.plantFormView()
            }
    }

    private func addReminder() -> some View {
        Button(action: viewModel.didTapAddActivity) { Text("Add Activity") }
            .sheet(isPresented: $viewModel.showsReminderFormView) {
                self.viewModel.plantActivityFormView()
            }
    }
}
