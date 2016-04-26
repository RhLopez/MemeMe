//
//  MemeDetialViewController.swift
//  MemeMe
//
//  Created by Ramiro H. Lopez on 4/25/16.
//  Copyright © 2016 Ramiro H. Lopez. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        tabBarController?.tabBar.hidden = true
        memeImageView.image = meme.memedImage
    }
}
