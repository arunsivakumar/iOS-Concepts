//
//  Colors..swift
//  MobileDesignSystems
//
//  Created by Arun Sivakumar on 23/2/20.
//  Copyright © 2020 Arun Sivakumar. All rights reserved.
//

import UIKit

enum ColorType: String {
    case clred
    case clgreen
    case clblue
    case clwhite
}

extension UIColor {
    static func color(type: ColorType) -> UIColor {
        UIColor(named: type.rawValue) ?? UIColor.white
    }
}
