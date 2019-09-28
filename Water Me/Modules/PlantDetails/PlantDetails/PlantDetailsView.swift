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

struct PlantDetailsView: View {
    @ObservedObject var viewModel: PlantDetailsViewModel

    init(viewModel: PlantDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                self.contentView(size: geometry.size)
                self.activities()
                Text(self.viewModel.nickName)
                self.addReminder()
                Spacer()
            }
        }
        .navigationBarTitle(viewModel.nickName)
        .navigationBarItems(trailing: editButton())
    }
}

// MARK: - Private Methods
extension PlantDetailsView {
    private func contentView(size: CGSize) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .center) {
                ForEach(self.viewModel.images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        .shadow(radius: 10)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: size.width, alignment: .center)
                }
            }
        }
    }

    private func activities() -> some View {
        Text("Water")
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
