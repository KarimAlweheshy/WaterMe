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

struct ImagePickerViewController {
    @Binding var images: [UIImage]
    @Binding var isShown: Bool
    private let type: ImagePickerType

    public init(images: Binding<[UIImage]>, isShown: Binding<Bool>, type: ImagePickerType) {
        self.type = type
        _images = images
        _isShown = isShown
    }
}

// MARK: - UIViewControllerRepresentable
extension ImagePickerViewController: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePickerViewController>) {
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerViewController>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        let sourceType: UIImagePickerController.SourceType = type == .photos ? .photoLibrary : .camera
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType) ?? [String]()
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate {
        let parent: ImagePickerViewController

        init(_ parent: ImagePickerViewController) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imagePicked = info[.originalImage] as! UIImage
            parent.images.insert(imagePicked, at: 0)
            parent.isShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isShown = false
        }
    }
}
