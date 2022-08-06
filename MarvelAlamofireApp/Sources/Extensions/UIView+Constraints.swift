//
//  UIView Constraints.swift
//  MarvelAlamofireApp
//
//  Created by Elena Noack on 01.08.22.
//

import UIKit


extension UIView {
    
    func addSubviewsForAutoLayout(_ views: [UIView]) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }

}



