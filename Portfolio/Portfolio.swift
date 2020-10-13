//
//  Portfolio.swift
//  Portfolio
//
//  Created by Paul Weichhart on 25.07.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import SwiftUI

@main
struct Portfolio: App {
    
    private let networkLayer = NetworkLayer()
    
    var body: some Scene {
        WindowGroup {
            let coordinator = Coordinator(networkLayer: networkLayer)
            
            let root = coordinator.navigate(to: .rootView)
            root.environmentObject(coordinator)
        }
    }
}
