//
//  NetworkLayer.swift
//  Portfolio
//
//  Created by Paul Weichhart on 06.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Combine
import Foundation
import Network

final class NetworkLayer {
    
    private static let endpoint = URL(string: "https://finnhub.io/api/v1/stock/symbol?exchange=US&token=\(token)")
    private static let token = "brecr1nrh5rckh45a7g0"
    
    private let decoder = JSONDecoder()
    private var cancellable: Set<AnyCancellable>?
    
    lazy var symbolsSubject: AnyPublisher<[NetworkSymbol], Never> = {
        return self.fetchSymbols()
    }()

    // MARK: - Private
    
    private func fetchSymbols() -> AnyPublisher<[NetworkSymbol], Never> {
        var request = URLRequest(url: NetworkLayer.endpoint!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .retry(3)
            .map { $0.data }
            .decode(type: [NetworkSymbol].self, decoder: self.decoder)
            .receive(on: RunLoop.main)
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
