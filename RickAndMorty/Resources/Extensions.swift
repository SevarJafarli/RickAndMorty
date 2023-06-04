//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Sevar Jafarli on 03.05.23.
//

import UIKit


extension UIView {
    func addSubviews(_ views: UIView...){
        views.forEach { view in
            addSubview(view)
        }
    }
}
