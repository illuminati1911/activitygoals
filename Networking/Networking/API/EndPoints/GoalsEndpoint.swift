//
//  GoalsEndpoint.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

struct GoalsEndpoint: EndPoint {
    var base: String {
        return "https://thebigachallenge.appspot.com/"
    }

    var path: String {
        return "/_ah/api/myApi/v1/goals"
    }

    var query: String { return "" }

    var parameters: [String: Any]?

}
