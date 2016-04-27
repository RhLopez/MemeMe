//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Ramiro H. Lopez on 4/25/16.
//  Copyright © 2016 Ramiro H. Lopez. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    override func viewDidAppear(animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        tabBarController?.tabBar.hidden = false
    }
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    @IBAction func createMeme(sender: AnyObject) {
        let memeEditorVC = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        presentViewController(memeEditorVC, animated: true, completion: nil)
    }
    
    // MARK: -UICollectionView 
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath) as! SentMemeCustomCollectionCell
        
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        memeDetailVC.meme = memes[indexPath.row]
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
}
