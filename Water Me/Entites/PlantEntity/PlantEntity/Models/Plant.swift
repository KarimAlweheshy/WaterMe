//
//  Plant.swift
//  PlantEntity
//
//  Created by Karim Alweheshy on 09.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

public struct Plant: Identifiable, Codable {
    public let id: Int
    public let nickName: String
    public let botanicalName: String?
    public let imagesURL: [URL]
    public let careGuide: CareGuide

    public init(id: Int, nickName: String, botanicalName: String, imagesURL: [URL], careGuide: CareGuide) {
        self.id = id
        self.nickName = nickName
        self.botanicalName = botanicalName
        self.imagesURL = imagesURL
        self.careGuide = careGuide
    }
}
