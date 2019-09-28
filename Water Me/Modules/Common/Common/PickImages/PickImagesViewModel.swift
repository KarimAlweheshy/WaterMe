//
//  PickImagesViewModel.swift
//  Common
//
//  Created by Karim Alweheshy on 19.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Combine
import UIKit

public final class PickImagesViewModel: ObservableObject {
    @Published var showsPickImageSheet: Bool = false
    @Published var showsPickImageView: Bool = false
    @Published var imagePickerType: ImagePickerType = .camera
    @Published var image: UIImage?

    public init() {
    }

    public var imagesPublisher: AnyPublisher<UIImage?, Never> {
        $image.eraseToAnyPublisher()
    }

    public var publisher: AnyPublisher<UIImage?, Never> {
        $image.eraseToAnyPublisher()
    }
}
