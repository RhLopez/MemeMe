//
//  MemeTextAttributes.swift
//  MemeMe
//
//  Created by Ramiro H. Lopez on 5/5/16.
//  Copyright © 2016 Ramiro H. Lopez. All rights reserved.
//

import UIKit

struct MemeTextAttributes {
    let textFieldFontSize: CGFloat = 40
    let labelFontSize: CGFloat = 22
    var textAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeWidthAttributeName: -3.5,
        ]
    
    enum Type {
        case TextField
        case Label
    }
    
    mutating func textAttribute(type: Type) -> Dictionary<String, NSObject>{
        switch type {
        case .TextField:
            textAttributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-CondensedBlack", size: textFieldFontSize)!
            return textAttributes
        case .Label:
            textAttributes[NSFontAttributeName] = UIFont(name: "HelveticaNeue-CondensedBlack", size: labelFontSize)!
            return textAttributes
        }
    }
}