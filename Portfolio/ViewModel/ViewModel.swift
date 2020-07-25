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
    
    @Published var symbols: [CoreDataSymbol] = []
    @Published var searchText = "" {
        didSet {
            symbols = coreDataStack.fetchSymbols(search: searchText)
        }
    }
    
    private let networkLayer: NetworkLayer
    private let coreDataStack: CoreDataStack
    private var context: NSManagedObjectContext {
        return coreDataStack.persistentContainer.viewContext
    }
    
    private var subscriber: AnyCancellable?
    
    init(networkLayer: NetworkLayer, coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.networkLayer = networkLayer
        
        fetchSymbols()
    }
    
    private func fetchSymbols() {
        coreDataStack.deleteSymbols()
        fetchNetworkSymbols(completion: { [weak self] symbols in
            guard let self = self else { return }
            
            self.symbols = symbols.map { symbol in
                return CoreDataSymbol(networkSymbol: symbol, context: self.context)
            }
            self.coreDataStack.saveContext()
        })
    }
    
    private func fetchNetworkSymbols(completion: @escaping ([NetworkSymbol]) -> Void) {
        subscriber = networkLayer.fetchSymbols()
            .sink(receiveCompletion: { result in
                switch result {
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                    completion([])
                }
            }, receiveValue: { symbols in
                completion(symbols)
        })
    }
}
