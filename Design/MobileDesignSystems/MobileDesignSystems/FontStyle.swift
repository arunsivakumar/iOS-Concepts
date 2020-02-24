//
//  FontStyle.swift
//  MobileDesignSystems
//
//  Created by Arun Sivakumar on 23/2/20.
//  Copyright © 2020 Arun Sivakumar. All rights reserved.
//

import UIKit

extension UIFont {
    static func fontRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Menlo-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func fontBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Menlo-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func fontThin(size: CGFloat) -> UIFont {
        return UIFont(name: "Menlo-Thin", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
