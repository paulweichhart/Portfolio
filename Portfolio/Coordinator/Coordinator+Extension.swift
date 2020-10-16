//
//  Coordinator+Extension.swift
//  Portfolio
//
//  Created by Paul Weichhart on 16.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation
import SwiftUI

extension Coordinator {
    
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
                PortfolioView(viewModel: viewModel)
            }
        }
    }
}
