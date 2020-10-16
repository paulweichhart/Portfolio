//
//  Coordinator.swift
//  Portfolio
//
//  Created by Paul Weichhart on 05.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation
import SwiftUI

final class Coordinator: ObservableObject {
    
    enum Destination {
        case loadingView
        case rootView
        case shareView(symbol: Symbol)
    }
    
    private weak var networkLayer: NetworkLayer?
    
    init(networkLayer: NetworkLayer?) {
        self.networkLayer = networkLayer
    }
    
    func navigate(to destination: Destination) -> DestinationView {
        return DestinationView(destination: destination, networkLayer: networkLayer)
    }
}
