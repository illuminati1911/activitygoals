//
//  Result+Extensions.swift
//  Core
//
//  Created by Ville Välimaa on 2020/6/7.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

public extension Result {
    var isSuccess: Bool { if case .success = self { return true } else { return false } }
    var isError: Bool {  return !isSuccess  }
}
