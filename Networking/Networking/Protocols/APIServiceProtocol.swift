//
//  APIServiceProtocol.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/7.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core

public protocol APIServiceProtocol {
    func getGoals(_ completion: @escaping (Result<[Goalable], Error>) -> Void)
}
