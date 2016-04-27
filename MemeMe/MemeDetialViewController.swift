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
    var returnFromEditor: Bool?
    
    override func viewDidLoad() {
        let editButton = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: #selector(MemeDetailViewController.editButtonPressed))
        navigationItem.rightBarButtonItem = editButton
    }
    override func viewWillAppear(animated: Bool) {
        if returnFromEditor == true {
            navigationController?.popToRootViewControllerAnimated(true)
        } else {
            tabBarController?.tabBar.hidden = true
            memeImageView.image = meme.memedImage
        }
    }
    
    func editButtonPressed() {
        let memeEditorVC = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        memeEditorVC.meme = meme
        presentViewController(memeEditorVC, animated: true, completion: {
            self.returnFromEditor = true
        })
    }
}
