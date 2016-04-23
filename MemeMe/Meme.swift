//
//  Meme.swift
//  MemeMe
//
//  Created by Ramiro H. Lopez on 4/11/16.
//  Copyright © 2016 Ramiro H. Lopez. All rights reserved.
//

import UIKit

struct Meme {
    
    var topText: String
    var bottomText: String
    var image: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}