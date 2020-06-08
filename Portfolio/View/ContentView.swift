//
//  ContentView.swift
//  Portfolio
//
//  Created by Paul Weichhart on 06.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: SectionHeaderView(title: "Portfolio")) {
                    PortfolioView(symbols: viewModel.symbols)
                }
                .background(Color.white)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                Section(header: SectionHeaderView(title: "Watchlist")) {
                        WatchlistView()
                }
                .background(Color.white)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .navigationBarTitle("Portfolio", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

struct SectionHeaderView: View {
    
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .background(Color.white)
                .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
            Spacer()
        }
    }
}

struct PortfolioView: View {
    
    var symbols: [NetworkSymbol]
    
    var body: some View {
        ForEach(symbols, id: \.symbol) { symbol in
            HStack {
                Text(symbol.symbol)
                Text(symbol.title)
            }.padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        }
    }
}

struct WatchlistView: View {
    var body: some View {
        Text("This is my Watchlist")
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = ViewModel(network: Network(), coreDataStack: CoreDataStack())
        return ListView(viewModel: viewModel)
    }
}
