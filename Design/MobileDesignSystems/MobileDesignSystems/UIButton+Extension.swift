//
//  UIButton+Extension.swift
//  MobileDesignSystems
//
//  Created by Arun Sivakumar on 23/2/20.
//  Copyright © 2020 Arun Sivakumar. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case primaryDark
    case primaryLight
    case secondary
    
    var height: CGFloat {
        switch self {
        case .primaryDark: return 47
        case .primaryLight: return 47
        case .secondary: return 20
        }
    }
    
    var edgeInset: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}


extension UIButton {
    
    func set(style: ButtonStyle) {
        switch style {
        case .primaryDark:
            self.heightAnchor.constraint(equalToConstant: style.height).isActive = true
            self.contentEdgeInsets = style.edgeInset
            self.titleLabel?.font  = .fontRegular(size: 40)
            self.backgroundColor   = .color(type: .clblue)
            self.setTitleColor(.color(type: .clwhite), for: .normal)
            self.makeRoundedCorner(height: style.height)
        case .primaryLight:
            self.heightAnchor.constraint(equalToConstant: style.height).isActive = true
            self.contentEdgeInsets = style.edgeInset
            self.titleLabel?.font  = .fontRegular(size: 40)
            self.backgroundColor   = .color(type: .clwhite)
            self.setTitleColor(.color(type: .clblue), for: .normal)
            self.layer.borderColor = UIColor.color(type: .clblue).cgColor
            self.layer.borderWidth = 2.0
            self.makeRoundedCorner(height: style.height)
        case .secondary:
            self.heightAnchor.constraint(equalToConstant: style.height).isActive = true
            self.contentEdgeInsets = style.edgeInset
            self.titleLabel?.font  = .fontRegular(size: 20)
            self.backgroundColor   = .color(type: .clwhite)
            self.setTitleColor(.color(type: .clblue), for: .normal)
        }
    }
}

extension UIView {
    func makeRoundedCorner(height: CGFloat) {
        self.layer.cornerRadius = height / 2
        self.clipsToBounds = true
    }
}
