//
//  ReminderFrequencyView.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity

struct ReminderFrequencyView: View {
    @ObservedObject var model: ReminderFrequencyModel

    public init(model: ReminderFrequencyModel) {
        self.model = model
    }

    var body: some View {
        Form {
            if model.frequency != .daily {
                Text(model.description)
            }
            Section {
                frequencyPicker()
                Stepper("Every \(model.frequencyDescription)", value: $model.every, in: 1...999)
            }
            frequencyDetailsSection()
        }
        .navigationBarTitle("Repeat")
    }
}

// MARK: - Frequency
extension ReminderFrequencyView {
    private func frequencyPicker() -> some View {
        Picker(selection: $model.frequency,
                      label: Text("Frequency")
        ) {
            ForEach(ReminderFrequencyModel.Frequency.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
    }
}

// MARK: - Frequency Details
extension ReminderFrequencyView {
    private func frequencyDetailsSection() -> some View {
        Section {
            if model.frequency == .weekly {
                weeklyDaysPicker()
            } else {
                EmptyView()
            }
        }
    }

    private func weeklyDaysPicker() -> some View {
        ForEach(WeekDay.allCases, id: \.self) { weekDay in
            Button(action: { self.model.toggleSelection(for: weekDay) }) {
                HStack {
                    Text(weekDay.rawValue.capitalized)
                    Spacer()
                    if self.model.isSelected(weekDay) {
                        Image(systemName: "checkmark")
                    } else {
                        EmptyView()
                    }
                }
            }.foregroundColor(.primary)
        }
    }
}
