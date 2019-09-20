//
//  PickImagesModel.swift
//  Common
//
//  Created by Karim Alweheshy on 19.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Combine
import UIKit

public final class PickImagesModel: ObservableObject {
    let title: String

    @Published var showsPickImageSheet: Bool = false
    @Published var showsPickImageView: Bool = false
    @Published var imagePickerType: ImagePickerType = .camera
    @Published var images: [UIImage]

    public init(title: String, images: [UIImage]) {
        self.title = title
        self.images = images
    }

    public var imagesPublisher: AnyPublisher<[UIImage], Never> {
        $images.eraseToAnyPublisher()
    }

    public var publisher: AnyPublisher<[UIImage], Never> {
        $images.eraseToAnyPublisher()
    }
}
