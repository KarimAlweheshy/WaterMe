//
//  PlantFormView.swift
//  PlantForm
//
//  Created by Karim Alweheshy on 10.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity
import Common

public struct PlantFormView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject public var model: PlantFormModel

    public init(model: PlantFormModel) {
        self.model = model
    }

    public var body: some View {
        NavigationView {
            form()
                .navigationBarTitle(Text("Add Plant"))
                .navigationBarItems(leading: cancelBarItem(), trailing: traillingBarItem())
        }
    }
}

// MARK: - Navigation Items
extension PlantFormView {
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
extension PlantFormView {
    private func form() -> some View {
        Form {
            plantDetailsSection()
            careSection()
        }
    }
}

// MARK: - Plant Details Section
extension PlantFormView {
    private func plantDetailsSection() -> some View {
        section(title: "Plant Details") {
            TextField("Plant nick name", text: $model.nickName)
            TextField("Botanical name", text: $model.botanicalName)
            plantImagesSection()
        }
    }

    private func plantImagesSection() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(model.images.isEmpty ? "Pick images for your plant" : "Images")
                Spacer()
                PickImagesButton(title: "Pick", images: $model.images)
            }
            HStack {
                ForEach(model.images, id: \.self) {
                    Image(uiImage: $0)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

// MARK: - Requirements Section
extension PlantFormView {
    private func careSection() -> some View {
        section(title: "Requirements") {
            waterDoseUnit()
            waterDoseValue()
            plantSoilSection()
            sunlightSection()
        }
    }

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
        Stepper("Water dose value: \(formattedWaterValue())", value: $model.waterValue, in: 0...10)
    }

    private func formattedWaterValue() -> String {
        let measurement = Measurement(value: model.waterValue,
                                      unit: model.waterUnit)
        return measurement.description
    }

    private func sunlightSection() -> some View {
        Picker(selection: $model.sunlight,
               label: Text("Sunlgiht")
        ) {
            ForEach(Sunlight.allCases, id: \.self) {
                Text($0.rawValue)
            }
        }
    }

    private func plantSoilSection() -> some View {
         Picker(selection: $model.soil,
                label: Text("Soil")
         ) {
             ForEach(Soil.allCases, id: \.self) {
                 Text($0.rawValue)
             }
         }
     }
}

// MARK: - Private Methods
extension PlantFormView {
    private func section<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        Section(header: HStack {
            Text(title).font(.title)
            Spacer()
        }) {
            content()
        }
    }
}
