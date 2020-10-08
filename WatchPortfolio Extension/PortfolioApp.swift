//
//  PortfolioApp.swift
//  WatchPortfolio Extension
//
//  Created by Paul Weichhart on 08.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import SwiftUI

@main
struct PortfolioApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
