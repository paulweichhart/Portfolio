//
//  Error.swift
//  Portfolio
//
//  Created by Paul Weichhart on 05.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case malformedURL
    case networkError
}

enum CommonError: Error {
    case configurationError
    case networkError
}
