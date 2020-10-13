//
//  PortfolioView.swift
//  Portfolio
//
//  Created by Paul Weichhart on 05.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation
import SwiftUI

struct PortfolioView: View {
    
    @StateObject private var viewModel: PortfolioViewModel
    
    init(viewModel: PortfolioViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HeaderView(searchText: $viewModel.searchText)
                
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
//            .navigationBarTitleDisplayMode(.large)
            .padding(EdgeInsets(top: 0, leading: 8.0, bottom: 0, trailing: 8.0))
            .navigationBarHidden(true)
        }
    }
}

struct HeaderView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Portfolio")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: -8, trailing: 8))
            TextField("Search for Symbol", text: $searchText)
                .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .clipped()
        }
    }
}

struct PortfolioList: View {
    
    let symbols: [Symbol]
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        List {
            ForEach(symbols, id: \.id) { symbol in
                
                NavigationLink(destination: coordinator.navigate(to: .shareView(symbol: symbol))) {
                    VStack(alignment: .leading) {
                        Text(symbol.id.localizedUppercase)
                            .bold()
                        Text(symbol.title).foregroundColor(Color.gray.opacity(0.7))
                    }.padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
        .listStyle(PlainListStyle())
    }
}
