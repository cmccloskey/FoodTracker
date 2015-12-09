//
//  ViewController.swift
//  FoodTracker
//
//  Created by Cristy McCloskey on 10/1/15.
//  Copyright © 2015 Cristy McCloskey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    //IBOutlet tells XCode that you can connect to the nameTextField
    //from Interface Builder (IB prefix)
    //weak means that it is possible for that property to have no
    //value (be nil) at some point in its life
    //the rest declares a variable of type UITextField named 
    //nameTextField
    //! indicates that the type is an implicitly unwrapped optional, 
    //which is an optional type that will always have a value after the 
    //value is first set
  
    @IBOutlet weak var mealNameLabel: UILabel!

    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: Actions
    
    //called when teh view controller's content view is created and loaded from a storyboard - intended
    //for initial setup - it may be called more than once
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //handle the text field's user input through delegate callbacks
        //ViewController is now a delegate for nameTextField
        nameTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        mealNameLabel.text = nameTextField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        //Dismiss the picker if the user canceled
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        //The info dictionary contains multiple representations of the image, and this uses the original
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the picker
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        
        //hide the keyboard
        nameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .PhotoLibrary
        //This line of code sets the image picker controller’s source, or the place where it gets its images. The .PhotoLibrary
        //option uses Simulator’s camera roll
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        
        presentViewController(imagePickerController, animated: true, completion: nil)
    }

    
    @IBAction func setDefaultLabelText(sender: UIButton) {
        
        mealNameLabel.text = "Default Text"
    }


}

