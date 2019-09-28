//
//  PickImagesButton.swift
//  Common
//
//  Created by Karim Alweheshy on 13.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI

public struct PickImagesButton<Content: View>: View {
    private let content: () -> Content
    @ObservedObject var viewModel: PickImagesViewModel

    public init(viewModel: PickImagesViewModel, @ViewBuilder content: @escaping () -> Content) {
        self.viewModel = viewModel
        self.content = content
    }

    public var body: some View {
        Button(action: { self.viewModel.showsPickImageSheet = true }, label: content)
            .actionSheet(isPresented: $viewModel.showsPickImageSheet,
                         content: pickImageSheet)
            .sheet(isPresented: $viewModel.showsPickImageView,
                   content: showImagePicker)
    }

    private func pickImageSheet() -> ActionSheet {
        ActionSheet(
            title: Text("Pick Plant Image"),
            message: Text("Add an image to your plant"),
            buttons: [
                .default(Text("Camera"), action: {
                    self.viewModel.imagePickerType = .camera
                    self.viewModel.showsPickImageView = true
                }),
                .default(Text("Photos"), action: {
                    self.viewModel.imagePickerType = .photos
                    self.viewModel.showsPickImageView = true
                }),
                .cancel()
            ])

    }

    private func showImagePicker() -> some View {
        ImagePickerViewController(image: $viewModel.image,
                                  isShown: $viewModel.showsPickImageView,
                                  type: viewModel.imagePickerType)
    }
}
