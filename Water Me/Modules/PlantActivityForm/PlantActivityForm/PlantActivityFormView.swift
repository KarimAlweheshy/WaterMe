//
//  PlantActivityFormView.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity
import Common
import ReminderForm

struct PlantActivityFormView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject public var viewModel: PlantActivityFormViewModel

    public init(viewModel: PlantActivityFormViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationView {
            form()
                .modifier(AdaptsToSoftwareKeyboard())
                .navigationBarTitle(Text("Add Activity"))
                .navigationBarItems(leading: cancelBarItem(), trailing: traillingBarItem())
        }
    }
}

// MARK: - Navigation Items
extension PlantActivityFormView {
    private func cancelBarItem() -> some View {
        Button(action: dismiss) { Text("Cancel") }
    }

    private func traillingBarItem() -> some View {
        Button(action: save) { Text("Save") }
    }

    private func dismiss() {
        presentation.wrappedValue.dismiss()
    }

    private func save() {
        viewModel.save()
        dismiss()
    }
}

// MARK: - Form
extension PlantActivityFormView {
    private func form() -> some View {
        Form {
            activityTypePicker()
            detailsSection()
            extrasSection()
        }
    }
}

// MARK: - Attachments
extension PlantActivityFormView {
    private func attachmentsSection() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "plus.app")
                Text(viewModel.images.isEmpty ? "Add attachments" : "Attachments")
                Spacer()
                PickImagesButton(viewModel: viewModel.pickImagesModel) { Text("Add") }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.images, id: \.self) {
                        Image(uiImage: $0)
                            .resizable()
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                    }
                }
            }
        }
    }
}

// MARK: - Extras
extension PlantActivityFormView {
    private func extrasSection() -> some View {
        Section(header: Text("Extras").font(.title)) {
            HStack {
                Image(systemName: "doc")
                TextField("Notes", text: $viewModel.notes).lineLimit(3)
            }
            attachmentsSection()
        }
    }
}

// MARK: - Activity Picker
extension PlantActivityFormView {
    private func activityTypePicker() -> some View {
        HStack {
            Image(systemName: "info.circle")
            Picker(selection: $viewModel.category,
                   label: Text("About")
            ) {
                ForEach(viewModel.possibleActivities, id: \.self) {
                    Text($0.rawValue)
                }
            }
        }
    }
}

// MARK: - Details Section
extension PlantActivityFormView {
    private func detailsSection() -> some View {
        Section(
            header: HStack {
                Text("Details").font(.title)
                Spacer()
            },
            content: detailsSectionDetails
        )
    }

    private func detailsSectionDetails() -> some View {
        Group {
            if viewModel.category == .water {
                WaterPlantActivityFormView(viewModel: .init())
            } else {
                Text("")
            }
        }
    }
}
