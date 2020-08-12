//
//  ViewModel.swift
//  Portfolio
//
//  Created by Paul Weichhart on 07.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Combine
import CoreData
import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    
    @Published var symbols: [NetworkSymbol] = []
    @Published var searchText: String = ""
    
    private let networkLayer: NetworkLayer
    private let coreDataStack: CoreDataStack
    private var context: NSManagedObjectContext {
        return coreDataStack.persistentContainer.viewContext
    }
    private var cancellable = Set<AnyCancellable>()
    
    init(networkLayer: NetworkLayer, coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.networkLayer = networkLayer

        subscribe()
    }
    
    private func subscribe() {
        Publishers.CombineLatest(networkLayer.symbolsSubject, $searchText)
            .map { symbols, text in
                let search = text.lowercased()
                return search.count < 3 ? symbols : symbols.filter { symbol in
                    symbol.display.lowercased().contains(search) ||
                        symbol.symbol.lowercased().contains(search) ||
                        symbol.title.lowercased().contains(search)
                }
            }
            .eraseToAnyPublisher()
            .assign(to: &$symbols)
    }
}
