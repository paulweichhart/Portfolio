//
//  ShareWatchView.swift
//  Portfolio
//
//  Created by Paul Weichhart on 16.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation
import SwiftUI

struct ShareWatchView: View {
    
    @StateObject private var viewModel: ShareViewModel
    
    init(viewModel: ShareViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
        }
        .navigationTitle(viewModel.symbol.title)
    }
}
