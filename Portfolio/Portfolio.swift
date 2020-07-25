//
//  Portfolio.swift
//  Portfolio
//
//  Created by Paul Weichhart on 25.07.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
@main
struct Portfolio: App {
    
    private let coreDataStack = CoreDataStack()
    private let networkLayer = NetworkLayer()
    
    var body: some Scene {
        WindowGroup {
            ListView(viewModel: ViewModel(networkLayer: networkLayer,
                                          coreDataStack: coreDataStack))
        }
    }
}

