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
                .navigationBarTitle(Text("Add Reminder"))
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
            reminderInterval()
            reminderTypePicker()
            detailsSection()
            extrasSection()
        }
    }
}

// MARK: - Reminder Interval
extension PlantActivityFormView {
    private func reminderInterval() -> some View {
        NavigationLink(
            destination: viewModel.reminderFormView()
        ) {
            HStack {
                Image(systemName: "repeat")
                Text("Remind me \(viewModel.occurrence.description)")
            }
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
                PickImagesButton(model: viewModel.pickImagesModel)
            }
            HStack {
                ForEach(viewModel.images, id: \.self) {
                    Image(uiImage: $0)
                        .resizable()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        .shadow(radius: 10)
                        .frame(width: 100, height: 100, alignment: .center)
                        .aspectRatio(contentMode: .fit)
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

// MARK: - Type Picker
extension PlantActivityFormView {
    private func reminderTypePicker() -> some View {
        HStack {
            Image(systemName: "info.circle")
            Picker(selection: $viewModel.category,
                   label: Text("About")
            ) {
                ForEach(PlantActivities.Category.allCases, id: \.self) {
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
