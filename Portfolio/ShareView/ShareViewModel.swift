//
//  ShareViewModel.swift
//  Portfolio
//
//  Created by Paul Weichhart on 05.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation

final class ShareViewModel: ObservableObject {
    
    private(set) var symbol: Symbol
    private weak var networkLayer: NetworkLayer?
    
    init(symbol: Symbol, networkLayer: NetworkLayer?) {
        self.symbol = symbol
        self.networkLayer = networkLayer
        
        if(networkLayer == nil) {
            assertionFailure()
        }
    }
}
