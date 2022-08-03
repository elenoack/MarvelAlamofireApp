//
//  UIView+Alert.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 03.08.22.
//

import UIKit


extension UIViewController {

    func showAlert(title: String? = "Oops! Something went wrong...",
                   message: String? = nil,
                   actions: [UIAlertAction] = []) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }

        present(alert, animated: true, completion: nil)
    }

}
