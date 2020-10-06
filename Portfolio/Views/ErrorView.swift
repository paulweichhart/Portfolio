//
//  ErrorView.swift
//  Portfolio
//
//  Created by Paul Weichhart on 05.10.20.
//  Copyright © 2020 Paul Weichhart. All rights reserved.
//

import Foundation
import SwiftUI

struct ErrorView: View {
    
    let error: CommonError
    
    var body: some View {
        VStack {
            switch error {
            case .configurationError:
                Text("Something went wrong — please retry")
            case .networkError:
                Text("Couldn't load Symbols — please check your Internet Connection")
            }
        }.padding(EdgeInsets(top: 0, leading: 8.0, bottom: 0, trailing: 8.0))
    }
}
