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
    public static var dismiss = stringForKey("dismiss")

    // Errors
    //
    public static var errorUnknown = stringForKey("error_unknown")
    public static var errorHealthKitQuery = stringForKey("error_healthkit_query")
    public static var errorHealthKitAuth = stringForKey("error_healthkit_auth")
    public static var errorHealthKitAccess = stringForKey("error_healthkit_access")
    public static var errorNetworkingRequest = stringForKey("error_networking_request")
    public static var errorNetworkingPayload = stringForKey("error_networking_payload")
    public static var errorNetworkingResponse = stringForKey("error_networking_response")
    public static var errorNetworkingData = stringForKey("error_networking_data")
    public static var errorNetworkingDecoding = stringForKey("error_networking_decoding")
    public static var errorLocalStorageCreate = stringForKey("error_localstorage_create")
    public static var errorLocalStorageFetch = stringForKey("error_localstorage_fetch")
}
