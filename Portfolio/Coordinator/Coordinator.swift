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
            switch destination {
            
            case .loadingView:
                Text("Portfolio")
            
            case let .shareView(symbol):
                let viewModel = ShareViewModel(symbol: symbol, networkLayer: networkLayer)
                ShareView(viewModel: viewModel)
                
            case .rootView:
                let viewModel = PortfolioViewModel(networkLayer: networkLayer)
                isWatch ? PortfolioWatchView
                PortfolioView(viewModel: viewModel)
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
