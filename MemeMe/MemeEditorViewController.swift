//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Ramiro H. Lopez on 4/11/16.
//  Copyright © 2016 Ramiro H. Lopez. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navbar: UIToolbar!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var topTextFieldConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTextFiedConstraint: NSLayoutConstraint!
    
    var memedImage: UIImage?
    var meme: Meme?
    
    // Text attributes
    let memeTextAttributes = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.5,
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUITextfields(topTextField)
        configureUITextfields(bottomTextField)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        configureUIButtons()
        if let meme = meme {
            memeEditSetup(meme)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscibeFromKeyboardNotifications()
    }
    
    func configureUITextfields(textField: UITextField) {
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .Center
    }
    
    func configureUIButtons() {
        // Disable camera button is device does not have a camera
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        // Disable action button if user has not chosen an image
        if imagePickerView.image == nil && meme == nil {
            actionButton.enabled = false
        } else {
            actionButton.enabled = true
        }
    }
    
    @IBAction func userSelection(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sender.tag == 0 ? .Camera : .PhotoLibrary
        presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscibeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Adjust view to keep bottom textfield in view then keyboard appears on screen
    func keyboardWillShow(notication: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = getKeyboardHeight(notication) * -1
        }
    }
    
    // Adjust view to default setting after the keyboard has been dismissed
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        return keyboardSize.CGRectValue().height
    }
    
    func generateMemedImage() -> UIImage {
        // Hide navbar and toolbar before rendering view to image
        navbar.hidden = true
        toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Unhide navbar and toolbar after rendering view to image
        navbar.hidden = false
        toolbar.hidden = false
        
        return memedImage
    }
    
    func save() {
        // Create meme object
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imagePickerView.image!, memedImage: memedImage!)
        
        // Add meme to array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
        memedImage = generateMemedImage()
        
        let controller = UIActivityViewController(activityItems:[memedImage!], applicationActivities: nil)
        
        controller.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        // Reset to blank image and default text in textfields
        imagePickerView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        configureUIButtons()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // Adjust topTextField and bottomTextField constraints to allow better viewing of picture when
    // device orientation is in landscape
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            topTextFieldConstraint.constant = 10
            bottomTextFiedConstraint.constant = 10
        } else {
            topTextFieldConstraint.constant = 60
            bottomTextFiedConstraint.constant = 60
        }
    }
    
    func memeEditSetup(meme: Meme) {
        topTextField.text = meme.topText
        bottomTextField.text = meme.bottomText
        imagePickerView.image = meme.image
    }
}

// MARK: UIImagePickerControlDelegate
extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

// MARK: UITextFieldDelegate
extension MemeEditorViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


