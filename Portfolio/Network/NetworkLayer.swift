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
    
    private static let symbolsURL = URL(string: "https://www.paulweichhart.com/symbols.json")
    private let decoder = JSONDecoder()
    
    var symbols: AnyPublisher<[Symbol], RequestError> {
        let publisher: AnyPublisher<[Symbol], RequestError> = fetch(url: Self.symbolsURL)
        return publisher
            .map { symbols in
                return symbols.sorted(by: { $0.id < $1.id })
            }
            .eraseToAnyPublisher()
    }
    
    private func fetch<NetworkModel: Codable>(url: URL?) -> AnyPublisher<NetworkModel, RequestError> {
        guard let url = url else {
            return Result<NetworkModel, RequestError>
                .Publisher(.failure(.malformedURL))
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .retry(3)
            .map { $0.data }
            .decode(type: NetworkModel.self, decoder: self.decoder)
            .receive(on: RunLoop.main)
            .mapError { _ in return .networkError }
            .eraseToAnyPublisher()
    }
}
