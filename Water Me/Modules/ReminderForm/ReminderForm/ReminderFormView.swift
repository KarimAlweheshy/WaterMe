//
//  ReminderFormView.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import Common
import PlantEntity

struct ReminderFormView: View {
    @ObservedObject var viewModel: ReminderFormViewModel

    public init(viewModel: ReminderFormViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        Form {
            if viewModel.frequency != .daily {
                Text(viewModel.description)
            }
            Section {
                frequencyPicker()
                Stepper("Every \(viewModel.frequencyDescription)", value: $viewModel.every, in: 1...999)
            }
            frequencyDetailsSection()
        }
        .navigationBarTitle("Repeat")
    }
}

// MARK: - Frequency
extension ReminderFormView {
    private func frequencyPicker() -> some View {
        Picker(selection: $viewModel.frequency,
                      label: Text("Frequency")
        ) {
            ForEach(ReminderFormViewModel.Frequency.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
    }
}

// MARK: - Frequency Details
extension ReminderFormView {
    private func frequencyDetailsSection() -> some View {
        Section {
            if viewModel.frequency == .weekly {
                weeklyDaysPicker()
            } else {
                EmptyView()
            }
        }
    }

    private func weeklyDaysPicker() -> some View {
        ForEach(WeekDay.allCases, id: \.self) { weekDay in
            Button(action: { self.viewModel.toggleSelection(for: weekDay) }) {
                HStack {
                    Text(weekDay.rawValue.capitalized)
                    Spacer()
                    if self.viewModel.isSelected(weekDay) {
                        Image(systemName: "checkmark")
                    } else {
                        EmptyView()
                    }
                }
            }.foregroundColor(.primary)
        }
    }
}
