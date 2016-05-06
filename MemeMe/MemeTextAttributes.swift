//
//  MemeTextAttributes.swift
//  MemeMe
//
//  Created by Ramiro H. Lopez on 5/4/16.
//  Copyright © 2016 Ramiro H. Lopez. All rights reserved.
//

import UIKit

struct MemeTextAttributes {
    
    let textFieldTextSize: CGFloat = 40
    let labelTextSize: CGFloat = 18
        
    enum Type {
        case TextField
        case Label
    }
    
    
    func getAttribute(type: Type) -> Dictionary<String, AnyObject>{
        var textAttribute = [
            NSStrokeColorAttributeName: UIColor.blackColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSStrokeWidthAttributeName: -3.5,
            ]
        
        switch type {
        case .TextField:
            textAttribute = [NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: textFieldTextSize)!]
        case .Label:
            textAttribute = [NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: labelTextSize)!]
        }
        
        return textAttribute
    }
    
}
