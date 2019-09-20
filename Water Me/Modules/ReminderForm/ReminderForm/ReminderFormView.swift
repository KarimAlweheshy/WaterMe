//
//  ReminderFormView.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import Common

public struct ReminderFormView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject public var model: ReminderFormModel

    public init(model: ReminderFormModel) {
        self.model = model
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
extension ReminderFormView {
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
        model.save()
        dismiss()
    }
}

// MARK: - Form
extension ReminderFormView {
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
extension ReminderFormView {
    private func reminderInterval() -> some View {
        NavigationLink(
            destination: ReminderFrequencyView(model: model.reminderFrequencyModel)
        ) {
            HStack {
                Image(systemName: "repeat")
                Text("Remind me \(model.reminderOccurance.description)")
            }
        }
    }
}

// MARK: - Attachments
extension ReminderFormView {
    private func attachmentsSection() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "plus.app")
                Text(model.images.isEmpty ? "Add attachments" : "Attachments")
                Spacer()
                PickImagesButton(model: model.pickImagesModel)
            }
            HStack {
                ForEach(model.images, id: \.self) {
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
extension ReminderFormView {
    private func extrasSection() -> some View {
        Section(header: Text("Extras").font(.title)) {
            HStack {
                Image(systemName: "doc")
                TextField("Notes", text: $model.notes).lineLimit(3)
            }
            attachmentsSection()
        }
    }
}

// MARK: - Type Picker
extension ReminderFormView {
    private func reminderTypePicker() -> some View {
        HStack {
            Image(systemName: "info.circle")
            Picker(selection: $model.type,
                   label: Text("About")
            ) {
                ForEach(ReminderType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
        }
    }
}

// MARK: - Details Section
extension ReminderFormView {
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
            if model.type == .water {
                WaterReminderFormView(model: .init())
            } else {
                Text("")
            }
        }
    }
}
