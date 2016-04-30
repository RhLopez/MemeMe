//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Ramiro H. Lopez on 4/23/16.
//  Copyright © 2016 Ramiro H. Lopez. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UITableViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    let textLabelAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSStrokeWidthAttributeName: -3.5,
    ]
    override func viewDidAppear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
        tableView.reloadData()
    }

        
    // MARK: -UITableViewController
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sentMemeCell") as! SentMemeCustomCell
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.image
        cell.topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: textLabelAttributes)
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: textLabelAttributes)
        cell.memeLabel.text = meme.topText + "..." + meme.bottomText
    
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memeDetailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        memeDetailVC.meme = memes[indexPath.row]
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
}
