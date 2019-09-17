//
//  WaterReminderFormView.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import Common

struct WaterReminderFormView: View {
    @ObservedObject public var model: WaterReminderFormModel
    
    var body: some View {
        Group {
            waterDoseUnit()
            waterDoseValue()
            lastWattered()
        }
    }
}

// MARK: - Private Methods
extension WaterReminderFormView {
    private func waterDoseUnit() -> some View {
        Picker(selection: $model.waterUnit,
               label: Text("Water dose unit")
        ) {
            ForEach(UnitVolume.allCases, id: \.self) {
                Text($0.symbol)
            }
        }
    }

    private func waterDoseValue() -> some View {
        Stepper("Water dose value: \(formattedWaterValue())", value: $model.waterValue, in: 1...1000)
    }

    private func lastWattered() -> some View {
        DatePicker(selection: $model.lastWattered, in: ...Date(), displayedComponents: .date) {
            Text("Last wattered \(formattedLastWatteredDate())")
        }
    }
}

// MARK: - Helpers
extension WaterReminderFormView {
    private func formattedWaterValue() -> String {
        let measurement = Measurement(value: model.waterValue,
                                      unit: model.waterUnit)
        return measurement.description
    }

    private func formattedLastWatteredDate() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.formattingContext = .middleOfSentence
        formatter.dateTimeStyle = .named
        return formatter.localizedString(for: model.lastWattered,
                                         relativeTo: Calendar.current.startOfDay(for: Date()))
    }
}
