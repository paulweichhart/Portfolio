//
//  ContentView.swift
//  Portfolio
//
//  Created by Paul Weichhart on 06.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import SwiftUI

struct ListView: View {
    
    let highlight = Color(.displayP3, red: 30/255, green: 186/255, blue: 208/255, opacity: 1)
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text("Portfolio")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: -16, trailing: 0))
                    SearchBarView(searchText: $viewModel.searchText, highlight: highlight)
                }.padding(EdgeInsets(top: 0, leading: 16.0, bottom: 0, trailing: 16.0))
                List {
                    PortfolioView(symbols: viewModel.symbols)
                    
//                    Section(header: SectionHeaderView(title: "Watchlist")) {
//                        WatchlistView()
//                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
//                    }
//                    .background(Color.white)
//                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                .navigationBarTitle("Portfolio", displayMode: .large)
                .navigationBarHidden(true)
                .navigationBarItems(trailing:
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus")
                    }
                )
            }
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
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))
            Spacer()
        }
    }
}

struct SearchBarView: View {
    
    @Binding var searchText: String
    @State private var showCancelButton: Bool = false
    var onCommit: () -> Void = { print("onCommit") }
    var highlight: Color
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                // Search text field
                ZStack(alignment: .leading) {
                    if searchText.isEmpty { // Separate text for placeholder to give it the proper color
                        Text("Search")
                    }
                    TextField("", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: onCommit)
                        .foregroundColor(.primary)
                        .accentColor(highlight)
                }
                
                // Clear button
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.tertiarySystemFill))
            .cornerRadius(10.0)
            
            if showCancelButton  {
                // Cancel button
                Button("Cancel") {
                    UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                    self.searchText = ""
                    self.showCancelButton = false
                }
                .foregroundColor(highlight)
            }
        }
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{ $0.isKeyWindow }
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        modifier(ResignKeyboardOnDragGesture())
    }
}

struct PortfolioView: View {
    
    let symbols: [CoreDataSymbol]
    
    var body: some View {
        ForEach(symbols, id: \.id) { symbol in
            HStack {
                Text(symbol.id)
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
        let viewModel = ViewModel(networkLayer: NetworkLayer(), coreDataStack: CoreDataStack())
        return ListView(viewModel: viewModel)
    }
}
