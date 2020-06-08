//
//  Utils.swift
//  Core
//
//  Created by Ville Välimaa on 2020/6/8.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

/// with: Useful function to configure objects within a scope and return configured instance
///
public func with<T>(_ configurable: T, _ handler: (T) -> Void) -> T {
    handler(configurable)
    return configurable
}
