//
//  Stock.swift
//  Portfolio
//
//  Created by Paul Weichhart on 06.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation

struct Stock {
    
    let index: String
    let value: Double
    let tradedSince: Date
    let history: [History]
}

struct History {
    
    let date: Date
    let value: Double
}

struct Watchlist {
    
    let watchlist: [Stock]
    let tradedSince: Date
}

struct NetworkSymbol: Codable {
    
    let id = UUID()
    let title: String
    let display: String
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case title = "description"
        case display = "displaySymbol"
        case symbol
    }
}
