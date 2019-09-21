//
//  WaterPlantActivityFormView.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import Common

struct WaterPlantActivityFormView: View {
    @ObservedObject public var viewModel: WaterPlantActivityFormViewModel
    
    var body: some View {
        Group {
            waterDoseUnit()
            waterDoseValue()
            lastWattered()
        }
    }
}

// MARK: - Private Methods
extension WaterPlantActivityFormView {
    private func waterDoseUnit() -> some View {
        HStack {
            Image(systemName: "cloud.rain")
            Picker(selection: $viewModel.waterUnit,
                   label: Text("Water dose unit")
            ) {
                ForEach(UnitVolume.allCases, id: \.self) {
                    Text($0.symbol)
                }
            }
        }
    }

    private func waterDoseValue() -> some View {
        HStack {
            Image(systemName: "plusminus.circle")
            Stepper("Water dose value: \(formattedWaterValue())", value: $viewModel.waterValue, in: 1...50)
        }
    }

    private func lastWattered() -> some View {
        HStack {
            Image(systemName: "calendar")
            DatePicker("Last watered \(formattedLastWatteredDate())",
                       selection: $viewModel.lastWattered, in: ...Date(),
                       displayedComponents: .date)
        }
    }
}

// MARK: - Helpers
extension WaterPlantActivityFormView {
    private func formattedWaterValue() -> String {
        let measurement = Measurement(value: viewModel.waterValue,
                                      unit: viewModel.waterUnit)
        return measurement.description
    }

    private func formattedLastWatteredDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.formattingContext = .middleOfSentence
        formatter.dateTimeStyle = .named
        return formatter.localizedString(for: viewModel.lastWattered,
                                         relativeTo: Calendar.current.startOfDay(for: Date()))
    }
}
