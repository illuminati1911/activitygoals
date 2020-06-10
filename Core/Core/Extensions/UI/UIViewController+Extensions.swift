//
//  UIViewController+Extensions.swift
//  Core
//
//  Created by Ville Välimaa on 2020/6/9.
//  Copyright © 2020 Ville Välimaa. All rights reserved.
//

import Foundation
import UIKit

/// UIViewController extentions
/// - showAlert: show alert popup.
///
public extension UIViewController {
    func showAlert(_ title: String, description: String? = nil, buttonTitle: String? = nil) {
        let alertController = UIAlertController(title: title, message:
            description, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle ?? Localized.dismiss, style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
}
