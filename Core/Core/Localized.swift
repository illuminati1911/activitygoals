//
//  Localized.swift
//  Core
//
//  Created by Ville Välimaa on 2020/6/9.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation

public class Localized {
    public static func stringForKey(_ key: String) -> String {
        NSLocalizedString(key, bundle: Bundle(for: Localized.self), comment: "")
    }

    public static func stringForKeyWithParams(_ key: String, _ arguments: CVarArg...) -> String {
        String(format: stringForKey(key), arguments: arguments)
    }

    public static var appTitle = stringForKey("app_title")
    public static var errorTitle = stringForKey("error_title")
    public static var unitMeters = stringForKey("unit_meters")
    public static var unitSteps = stringForKey("unit_steps")
    public static var goalCompleted = stringForKey("goal_complete")

}
