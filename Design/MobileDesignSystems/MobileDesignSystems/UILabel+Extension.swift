//
//  UILabel+Extension.swift
//  MobileDesignSystems
//
//  Created by Arun Sivakumar on 23/2/20.
//  Copyright © 2020 Arun Sivakumar. All rights reserved.
//

import UIKit

//enum LabelStyle {
//    case largeTitle // 34
//    case title1 //28
//    case title2 //22
//    case title3 //20
//    case headline //17
//    case callout //16
//    case subheadline //15
//    case body //17
//    case footnote //13
//    case caption1 //12
//    case caption2 //11
//}

extension UILabel {
    func set(style: UIFont.TextStyle) {
        var customFont: UIFont!
        switch style {
        case .largeTitle:
            customFont = UIFont.fontBold(size: 34.0)
            self.textColor = .color(type: .clblue)
        case .title1:
            customFont = UIFont.fontBold(size: 28.0)
            self.textColor = .color(type: .clgreen)
        case .title2:
            customFont = UIFont.fontBold(size: 22.0)
            self.textColor = .color(type: .clred)
        case .title3:
            customFont = UIFont.fontBold(size: 20.0)
            self.textColor = .color(type: .clred)
        case .headline:
            customFont = UIFont.fontRegular(size: 17.0)
            self.textColor = .color(type: .clblue)
        case .callout:
            customFont = UIFont.fontRegular(size: 16.0)
            self.textColor = .color(type: .clgreen)
        case .subheadline:
            customFont = UIFont.fontRegular(size: 15.0)
            self.textColor = .color(type: .clblue)
        case .body:
            customFont = UIFont.fontRegular(size: 17.0)
            self.textColor = .darkGray
            self.numberOfLines = 0
            self.lineBreakMode = .byWordWrapping
        case .footnote:
            customFont = UIFont.fontThin(size: 13.0)
            self.textColor = .lightGray
        case .caption1:
            customFont = UIFont.fontRegular(size: 12.0)
            self.textColor = .color(type: .clblue)
        case .caption2:
            customFont = UIFont.fontRegular(size: 11.0)
            self.textColor = .color(type: .clblue)
        default:
            break
        }
        // support for dynamic type
        let fontMetrics = UIFontMetrics(forTextStyle: style)
        self.font = fontMetrics.scaledFont(for: customFont)
        self.adjustsFontForContentSizeCategory = true
    }
}
