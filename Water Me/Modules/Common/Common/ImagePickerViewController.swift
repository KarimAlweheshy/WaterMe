//
//  ImagePickerViewController.swift
//  Common
//
//  Created by Karim Alweheshy on 13.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftUI

public enum ImagePickerType {
    case camera
    case photos
}

public struct ImagePickerViewController {
    @Binding var images: [UIImage]
    @Binding var isShown: Bool
    private let type: ImagePickerType

    public init(images: Binding<[UIImage]>,
                isShown: Binding<Bool>,
                type: ImagePickerType) {
        self.type = type
        _isShown = isShown
        _images = images
    }
}

// MARK: - UIViewControllerRepresentable
extension ImagePickerViewController: UIViewControllerRepresentable {
    public typealias UIViewControllerType = UIImagePickerController

    public func updateUIViewController(_ uiViewController: UIImagePickerController,
                                       context: UIViewControllerRepresentableContext<ImagePickerViewController>) {
    }

    public func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerViewController>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        let sourceType: UIImagePickerController.SourceType = context.coordinator.type == .photos ? .photoLibrary : .camera
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType) ?? [String]()
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    public func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, images: $images, type: type)
    }

    public class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {

        @Binding var isShown: Bool
        @Binding var images: [UIImage]
        let type: ImagePickerType

        init(isShown: Binding<Bool>,
             images: Binding<[UIImage]>,
             type: ImagePickerType) {
            _isShown = isShown
            _images = images
            self.type = type
        }

        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imagePicked = info[.originalImage] as! UIImage
            images.insert(imagePicked, at: 0)
            picker.dismiss(animated: true) {
                self.isShown = false
            }
        }

        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isShown = false
        }
    }
}
