//
//  VerifyPhotoViewController.swift
//  PetWorld
//
//  Created by my mac on 5/27/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class VerifyPhotoViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var caption: UITextField!

    @IBOutlet weak var tabBar: HeaderView!
    
    @IBOutlet weak var chosenPicture: UIImageView!
    var picture: UIImage?
    
    var exitCallback: ((Void) -> (Void))?
    var postSuccesful: ((Post) -> (Void))?
    var postFailure: ((Post, Error) -> (Void))?
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        chosenPicture.image = picture
        caption.delegate = self
        self.tabBar.onClickCallBack = {
            self.dismiss(animated: true, completion: nil)
        }
        
        self.tabBar.titleText.textColor = UIColor.white
        
        self.tabBar.leftButton.tintColor = UIColor.white
        
        self.tabBar.color = ColorPalette.primary
        // Do any additional setup after loading the view.
    }

    @IBAction func onPost(_ sender: Any) {
        
        print("onPost() called!") 
        let api = NetworkAPI.sharedInstance
        guard let currentPet = Pet.currentPet() else {
            print("No current pet.")
            return;
        }
        // caption
        let captionText = caption.text
        // post photo
        let resizedImage = api.resize(photo: self.chosenPicture.image!, newSize: CGSize(width: 240, height: 240))
        
        let post = Post()
        //COMMIT... to the grind.
        post.author = currentPet
        post.authorId = currentPet.objectId!
        post.caption = captionText
        
        api.uploadImageFile(image: resizedImage, successHandler: { (mediaFile: MediaFile) in
            post.mediaFile = mediaFile
            post.image = mediaFile.image
            post.mediaId = mediaFile.objectId
            
            self.saveNewPost(post: post)
           
        }) { (error: Error) in
                print("[ERROR]: \(error)")
        }
        
    
    }
    
    
    
    func saveNewPost(post: Post){
        let api =   NetworkAPI.sharedInstance
        api.create(newPost: post, successHandler: {
            self.postDismiss()
        }, errorHandler: { (error: Error) in
            print("Could not create new post: \(error)")
        })
    }
   
    func postDismiss(){
        self.dismiss(animated: false) { 
            self.exitCallback?()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }


}
