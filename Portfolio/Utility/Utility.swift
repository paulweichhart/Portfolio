//
//  Utility.swift
//  Portfolio
//
//  Created by Paul Weichhart on 12.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation

var isWatch: Bool {
    #if os(watchOS)
        return true
    #else
        return false
    #endif
}
