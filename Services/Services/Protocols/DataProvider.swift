//
//  DataProvider.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/6.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core
import RxSwift

/// DataProvider: Provider of goals data from any source
///
public protocol DataProvider {
    func getGoals() -> Observable<[Goalable]>
}
