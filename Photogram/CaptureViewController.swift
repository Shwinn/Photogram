//
//  CaptureViewController.swift
//  Photogram
//
//  Created by Ashwin Gupta on 3/21/17.
//  Copyright © 2017 Ashwin Gupta. All rights reserved.
//

import UIKit

class CaptureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //imageButton.setBackgroundImage(nil, for: .normal)
        //imageButton.setTitle("Tap to take or select a photo", for: .normal)
        
    }

    @IBAction func onImageButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            print("Camera is available")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        }
        else {
            print("Camera is not available so photo library will be used instead")
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //let editedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        imageButton.setBackgroundImage(originalImage, for: .normal)
        imageButton.setTitle("", for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPostButton(_ sender: Any) {
        let resizedImage = resize(image: imageButton.backgroundImage(for: .normal)!, newSize: CGSize(width: 500, height: 500))
        Post.postUserImage(image: resizedImage, withCaption: captionTextField.text, withCompletion: { (success: Bool, error: Error?) in
                if success {
                    self.imageButton.setBackgroundImage(nil, for: .normal)
                    self.imageButton.setTitle("Tap to take or select a photo", for: .normal)
                    self.captionTextField.text = "Add a caption"
                    self.tabBarController?.selectedIndex = 0
                    //self.performSegue(withIdentifier: "newPostSegue", sender: nil)
                    print("Post success and switched to home tab")
                }
                else {
                    print(error?.localizedDescription)
                }
            })
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
