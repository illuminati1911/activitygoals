//
//  ActivityProvider.swift
//  Services
//
//  Created by Ville Välimaa on 2020/6/7.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import Core
import RxSwift

/// ActivityProvider: Provider of the activity data from any source
///
public protocol ActivityProvider {
    func getActivity() -> Observable<Activity>
}
