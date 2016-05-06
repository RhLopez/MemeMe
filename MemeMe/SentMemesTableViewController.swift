//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Ramiro H. Lopez on 4/23/16.
//  Copyright © 2016 Ramiro H. Lopez. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController {
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    @IBOutlet var memeTableView: UITableView!

    var labelTextAttribute = MemeTextAttributes()

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        memeTableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension SentMemesTableViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("sentMemeCell") as! SentMemeCustomCell
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.image
        cell.topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: labelTextAttribute.textAttribute(.Label))
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: labelTextAttribute.textAttribute(.Label))
        cell.memeLabel.text = meme.topText + "..." + meme.bottomText
    
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let memeDetailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        memeDetailVC.meme = memes[indexPath.row]
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.memes.removeAtIndex(indexPath.row)
            memeTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}

