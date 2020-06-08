//
//  ViewModel.swift
//  Portfolio
//
//  Created by Paul Weichhart on 07.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Combine
import Foundation

final class ViewModel: ObservableObject {
    
    @Published var symbols: [NetworkSymbol] = [] {
        didSet {
            storeSymbols()
        }
    }
    
    private let network: Network
    private let coreDataStack: CoreDataStack
    
    private var subscriber: AnyCancellable?
    
    init(network: Network, coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.network = network
        
        fetchSymbols()
    }
    
    private func fetchSymbols() {
        
        subscriber = network.fetchSymbols()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }, receiveValue: { [weak self] value in
                self?.symbols = value
            })
    }
    
    private func storeSymbols() {
        symbols.forEach { symbol in
            let _ = CoreDataSymbol(networkSymbol: symbol, context: coreDataStack.persistentContainer.viewContext)
        }
        coreDataStack.saveContext()
    }
}
