//
//  PickImagesButton.swift
//  Common
//
//  Created by Karim Alweheshy on 13.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI

public struct PickImagesButton: View {
    @ObservedObject var model: PickImagesModel

    public init(model: PickImagesModel) {
        self.model = model
    }

    public var body: some View {
        Button(model.title) { self.model.showsPickImageSheet = true }
            .actionSheet(isPresented: $model.showsPickImageSheet,
                         content: pickImageSheet)
            .sheet(isPresented: $model.showsPickImageView,
                   content: showImagePicker)
    }

    private func pickImageSheet() -> ActionSheet {
        ActionSheet(
            title: Text("Pick Plant Image"),
            message: Text("Add an image to your plant"),
            buttons: [
                .default(Text("Camera"), action: {
                    self.model.imagePickerType = .camera
                    self.model.showsPickImageView = true
                }),
                .default(Text("Photos"), action: {
                    self.model.imagePickerType = .photos
                    self.model.showsPickImageView = true
                }),
                .cancel()
            ])

    }

    private func showImagePicker() -> some View {
        ImagePickerViewController(images: $model.images, isShown: $model.showsPickImageView, type: model.imagePickerType).onDisappear {
            print("wtf")
        }
    }
}
