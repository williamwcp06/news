//
//  Alert.swift
//  News
//
//  Created by William on 10/03/23.
//

import Foundation
import UIKit

class Alert {
    static let instance = Alert()
    public func createAlert(_ controller: UIViewController, style: UIAlertController.Style = .alert, title: String? = nil, message: String? = nil, useTextfield: Bool = false, action: [UIAlertAction] = [UIAlertAction(title: "OK", style: .default)]) -> UIAlertController {
        let alert = UIAlertController(title: title == nil ? nil : "Error [\(title!)]", message: message, preferredStyle: style)
        if useTextfield {
            alert.addTextField { textfield in
                textfield.keyboardType = .numberPad
                textfield.placeholder = "Type here"
            }
        }
        
        action.forEach{
            alert.addAction($0)
        }
        DispatchQueue.main.async {
            controller.present(alert, animated: true)
        }
        return alert
    }
}
