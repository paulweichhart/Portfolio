//
//  Symbol.swift
//  Portfolio
//
//  Created by Paul Weichhart on 05.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation

struct Symbol: Codable {
    
    let id: String
    let title: String
    
    var tags: String {
        return id.localizedLowercase + " " + title.localizedLowercase
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "symbol"
        case title
    }
}
