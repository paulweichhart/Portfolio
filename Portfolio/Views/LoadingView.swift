//
//  LoadingView.swift
//  Portfolio
//
//  Created by Paul Weichhart on 05.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation
import SwiftUI

struct LoadingView: View {
    
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading")
                .padding(EdgeInsets(top: 0, leading: 8.0, bottom: 0, trailing: 8.0))
        }
    }
}
