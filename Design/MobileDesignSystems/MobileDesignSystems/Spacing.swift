//
//  Spacing.swift
//  MobileDesignSystems
//
//  Created by Arun Sivakumar on 23/2/20.
//  Copyright © 2020 Arun Sivakumar. All rights reserved.
//

import UIKit

enum Spacing: CGFloat {
    case standard = 8 // 8 px
    case standard2 = 16  // 16 px
    case standard3 = 32  // 32 px
    
    static func get(_ spacing: Spacing) -> CGFloat{
        return spacing.rawValue
    }
}
