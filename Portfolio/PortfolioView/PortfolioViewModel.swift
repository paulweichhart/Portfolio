//
//  PortfolioViewModel.swift
//  Portfolio
//
//  Created by Paul Weichhart on 07.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Combine
import Foundation

final class PortfolioViewModel: ObservableObject {
    
    @Published private(set) var symbols: Result<[Symbol], CommonError>?
    @Published var searchText = ""
    
    private weak var networkLayer: NetworkLayer?
    private var cancellables: Set<AnyCancellable> = []
    
    init(networkLayer: NetworkLayer?) {
        self.networkLayer = networkLayer
        
        subscribe()
    }
    
    private func subscribe() {
        
        guard let networkLayer = networkLayer else {
            assertionFailure("NetworkLayer Configuration Failure")
            return
        }
        
        Publishers.CombineLatest(networkLayer.symbols, $searchText.setFailureType(to: RequestError.self))
            .map { symbols, searchText in
                let text = searchText.localizedLowercase
                let result = text.count < 3 ? symbols : symbols.filter { $0.tags.contains(text) }
                return .success(result)
            }
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(error) where error == .malformedURL:
                    self?.symbols = .failure(.configurationError)
                case .finished:
                    break
                default:
                    self?.symbols = .failure(.networkError)
                }
            }, receiveValue: { [weak self] value in
                self?.symbols = value
            })
            .store(in: &cancellables)
    }
}
