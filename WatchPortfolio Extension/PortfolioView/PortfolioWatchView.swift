//
//  PortfolioWatchView.swift
//  WatchPortfolio Extension
//
//  Created by Paul Weichhart on 12.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation
import SwiftUI

struct PortfolioWatchView: View {
    
    @StateObject private var viewModel: PortfolioViewModel
    
    init(viewModel: PortfolioViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.symbols {
                    
                case let .success(symbols):
                    PortfolioList(symbols: symbols)
                        
                case let .failure(error):
                    Spacer()
                    ErrorView(error: error)
                    Spacer()
                    
                case .none:
                    Spacer()
                    LoadingView()
                    Spacer()
                }
            }
            .navigationTitle("Portfolio")
        }
    }
}
