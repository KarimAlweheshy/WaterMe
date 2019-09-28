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
        VStack {
            details()
            activities()
            Text(viewModel.nickName)
            addReminder()
        }
        .navigationBarTitle(viewModel.nickName)
        .navigationBarItems(trailing: editButton())
    }
}

// MARK: - Private Methods
extension PlantDetailsView {
    private func details() -> some View {
        GeometryReader { geometry in
            ScrollView {
                self.contentView(size: geometry.size)
            }
        }
    }

    private func contentView(size: CGSize) -> some View {
        HStack {
            ForEach(self.viewModel.images, id: \.self) {
                Image(uiImage: $0)
                    .resizable()
                    .frame(width: size.width, height: size.height / 3)
                    .padding()
            }
        }
    }

    private func activities() -> some View {
        Group {
            Section {
                Text("Water")
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
