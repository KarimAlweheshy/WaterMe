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
            HStack {
                Image(systemName: "smiley")
                TextField("Plant nick name", text: $model.nickName)
            }
            HStack {
                Text("⚘").font(.title)
                TextField("Botanical name", text: $model.botanicalName)
            }
            plantImagesSection()
        }
    }

    private func plantImagesSection() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "plus.app")
                Text(model.images.isEmpty ? "Pick images for your plant" : "Images")
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

// MARK: - Requirements Section
extension PlantFormView {
    private func careSection() -> some View {
        section(title: "Requirements") {
            plantSoilSection()
            sunlightSection()
        }
    }

    private func sunlightSection() -> some View {
        HStack {
            Image(systemName: "sun.max")
            Picker(selection: $model.sunlight,
                   label: Text("Sunlgiht")
            ) {
                ForEach(Sunlight.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
        }
    }

    private func plantSoilSection() -> some View {
        HStack {
            Image(systemName: "globe")
             Picker(selection: $model.soil,
                    label: Text("Soil")
             ) {
                 ForEach(Soil.allCases, id: \.self) {
                     Text($0.rawValue)
                 }
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
