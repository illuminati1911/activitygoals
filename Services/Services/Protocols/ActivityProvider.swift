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

public protocol ActivityProvider {
    func getActivity() -> Observable<Activity>
}
