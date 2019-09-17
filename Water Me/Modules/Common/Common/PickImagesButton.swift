//
//  PickImagesButton.swift
//  Common
//
//  Created by Karim Alweheshy on 13.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI

public struct PickImagesButton: View {
    @Binding public var images: [UIImage]
    private let title: String
    @State private var showsPickImageSheet: Bool = false
    @State private var showsPickImageView: Bool = false
    @State private var imagePickerType: ImagePickerType = .camera

    public init(title: String, images: Binding<[UIImage]>) {
        _images = images
        self.title = title
    }

    public var body: some View {
        Button(title) { self.showsPickImageSheet = true }
            .actionSheet(isPresented: $showsPickImageSheet,
                         content: pickImageSheet)
            .sheet(isPresented: $showsPickImageView,
                   content: showImagePicker)
    }

    private func pickImageSheet() -> ActionSheet {
        ActionSheet(
            title: Text("Pick Plant Image"),
            message: Text("Add an image to your plant"),
            buttons: [
                .default(Text("Camera"), action: {
                    self.imagePickerType = .camera
                    self.showsPickImageView = true
                }),
                .default(Text("Photos"), action: {
                    self.imagePickerType = .photos
                    self.showsPickImageView = true
                }),
                .cancel()
            ])

    }

    private func showImagePicker() -> some View {
        ImagePickerViewController(images: $images,
                                  isShown: $showsPickImageView,
                                  type: imagePickerType)
    }
}
