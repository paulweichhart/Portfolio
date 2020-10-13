//
//  ShareView.swift
//  Portfolio
//
//  Created by Paul Weichhart on 05.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation
import SwiftUI

struct ShareView: View {
    
    @StateObject private var viewModel: ShareViewModel
    
    var isAppleWatch: Bool {
        #if os(watchOS)
            return true
        #else
            return false
        #endif

    }
    
    init(viewModel: ShareViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
        }
        .navigationTitle(viewModel.symbol.title)
//      .navigationBarTitleDisplayMode(.large)
        .padding(EdgeInsets(top: 0, leading: 16.0, bottom: 0, trailing: 16.0))
    }
}
