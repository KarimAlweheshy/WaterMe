//
//  ReminderFormFactrory.swift
//  ReminderForm
//
//  Created by Karim Alweheshy on 21.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import SwiftUI
import PlantEntity

public struct ReminderFormFactory {
    public init() {}
    
    public func make(occurrence: Published<Occurrence>) -> some View {
        ReminderFormView(viewModel: .init(occurrence: occurrence))
    }
}
