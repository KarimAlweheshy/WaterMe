//
//  String+Helpers.swift
//  Common
//
//  Created by Karim Alweheshy on 17.09.19.
//  Copyright © 2019 Karim. All rights reserved.
//

import Foundation

extension String {
    public var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}
