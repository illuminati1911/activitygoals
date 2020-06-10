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

    // UI
    //
    public static let appTitle = stringForKey("app_title")
    public static let errorTitle = stringForKey("error_title")
    public static let unitMeters = stringForKey("unit_meters")
    public static let unitSteps = stringForKey("unit_steps")
    public static let goalCompleted = stringForKey("goal_complete")
    public static let dismiss = stringForKey("dismiss")

    // Errors
    //
    public static let errorUnknown = stringForKey("error_unknown")
    public static let errorHealthKitQuery = stringForKey("error_healthkit_query")
    public static let errorHealthKitAuth = stringForKey("error_healthkit_auth")
    public static let errorHealthKitAccess = stringForKey("error_healthkit_access")
    public static let errorNetworkingRequest = stringForKey("error_networking_request")
    public static let errorNetworkingPayload = stringForKey("error_networking_payload")
    public static let errorNetworkingResponse = stringForKey("error_networking_response")
    public static let errorNetworkingData = stringForKey("error_networking_data")
    public static let errorNetworkingDecoding = stringForKey("error_networking_decoding")
    public static let errorLocalStorageCreate = stringForKey("error_localstorage_create")
    public static let errorLocalStorageFetch = stringForKey("error_localstorage_fetch")
    public static let errorLocalStorageDelete = stringForKey("error_localstorage_delete")
}
