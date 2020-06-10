//
//  APIServiceProtocol.swift
//  Networking
//
//  Created by Ville Välimaa on 2020/6/7.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import RxSwift
import Core

/// APIServiceProtocol: protocol for the APIService of the workspace domain
///
public protocol APIServiceProtocol {
    func getGoals() -> Observable<[Goalable]>
}
