//
//  ReminderFormView.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI

public struct ReminderFormView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject public var model: ReminderFormModel

    public var body: some View {
        NavigationView {
            form()
                .navigationBarTitle(Text("Add Plant"))
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
            Text("Hello")
        }
    }
}
