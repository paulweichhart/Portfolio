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
    
    struct DestinationView: View {
        
        let destination: Destination
        weak var networkLayer: NetworkLayer?
        
        var body: some View {
            switch (destination, isWatch) {
            
            // Shared Destinations
            case (.loadingView, _):
                Text("Portfolio")
            
            // iPhone Destinations
            case let (.shareView(symbol), false):
                let viewModel = ShareViewModel(symbol: symbol, networkLayer: networkLayer)
                ShareView(viewModel: viewModel)
                
            case (.rootView, false):
                let viewModel = PortfolioViewModel(networkLayer: networkLayer)
                PortfolioView(viewModel: viewModel)
                
            // Watch Destinations
            case (.rootView, true):
                let viewModel = PortfolioViewModel(networkLayer: networkLayer)
                PortfolioWatchView(viewModel: viewModel)
                
            case let (.shareView(symbol), true):
                let viewModel = ShareViewModel(symbol: symbol, networkLayer: networkLayer)
                ShareWatchView(viewModel: viewModel)
            }
        }
    }
    
    private weak var networkLayer: NetworkLayer?
    
    init(networkLayer: NetworkLayer?) {
        self.networkLayer = networkLayer
    }
    
    func navigate(to destination: Destination) -> DestinationView {
        return DestinationView(destination: destination, networkLayer: networkLayer)
    }
}
