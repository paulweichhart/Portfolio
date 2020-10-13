//
//  PortfolioApp.swift
//  WatchPortfolio Extension
//
//  Created by Paul Weichhart on 08.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import SwiftUI

@main
struct PortfolioWatchApp: App {
    
    private let networkLayer = NetworkLayer()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            let coordinator = Coordinator(networkLayer: networkLayer)
            
            let root = coordinator.navigate(to: .rootView)
            root.environmentObject(coordinator)
        }
    }
}
