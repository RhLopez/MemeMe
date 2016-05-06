//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Ramiro H. Lopez on 4/25/16.
//  Copyright © 2016 Ramiro H. Lopez. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet var memeCollectionView: UICollectionView!
    
    var labelTextAttribute = MemeTextAttributes()
    
    var memes: [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidAppear(animated: Bool) {
        memeCollectionView.reloadData()
    }

    func getCellSize() -> CGSize {
        let space: CGFloat = 1.5
        let multiplier: CGFloat
        let divisor: CGFloat
        
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            multiplier = 6
            divisor = 5.0
        } else {
            multiplier = 2
            divisor = 3.0
        }
        
        let dimension = (view.bounds.width - (multiplier * space)) / divisor
        
        return CGSizeMake(dimension, dimension)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        collectionViewLayout.invalidateLayout()
    }
}

// MARK: - UICollectionViewDataSource
extension SentMemesCollectionViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCell", forIndexPath: indexPath) as! SentMemeCustomCollectionCell
        
        let meme = memes[indexPath.row]
        
        cell.memeImageView.image = meme.image
        cell.topLabel.attributedText = NSAttributedString(string: meme.topText, attributes: labelTextAttribute.textAttribute(.Label))
        cell.bottomLabel.attributedText = NSAttributedString(string: meme.bottomText, attributes: labelTextAttribute.textAttribute(.Label))
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetailVC = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        
        memeDetailVC.meme = memes[indexPath.row]
        navigationController?.pushViewController(memeDetailVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SentMemesCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return getCellSize()
    }
}

