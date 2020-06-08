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

//struct Portfolio {
//    
//    let portfolio: [Stock]
//    let tradedSince: Date
//}
