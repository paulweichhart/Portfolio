//
//  Network.swift
//  Portfolio
//
//  Created by Paul Weichhart on 06.06.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Combine
import Foundation
import Network

struct NetworkSymbol: Codable {
    
    let title: String
    let display: String
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case title = "description"
        case display = "displaySymbol"
        case symbol
    }
}

final class Network {
    
    private static let endpoint = URL(string: "https://finnhub.io/api/v1/stock/symbol?exchange=US&token=\(token)")
    private static let token = "brecr1nrh5rckh45a7g0"
    
    private let decoder = JSONDecoder()
    private var cancellable: AnyCancellable?
    
    func fetchSymbols() -> AnyPublisher<[NetworkSymbol], Error> {
        var request = URLRequest(url: Network.endpoint!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .map { $0.data }
            .decode(type: [NetworkSymbol].self, decoder: self.decoder)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
