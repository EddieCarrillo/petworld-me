//
//  PostTableViewCell.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/16/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit


class PostTableViewCell: UITableViewCell{
    
    
    
    
    //Click to see all comments
    @IBOutlet weak var commentButton: UIButton!
    
    //The profile picture on top left of the screen
    @IBOutlet weak var profilePictureButton: UIButton!
    //The actual post image/video
    @IBOutlet weak var photoImage: UIImageView!
    
    //Username display top left of the screen
    @IBOutlet weak var usernameButton: UIButton!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    var isLiked = false
    
    @IBOutlet weak var likeButton: UIButton!
    
    
    @IBAction func onLikeButtonTapped(_ sender: UIButton) {
        
        if (isLiked){
            isLiked = false
           likeButton.isSelected = false
            
        }else{
            isLiked = true
            likeButton.isSelected = true
        
        }
    }
    
    var post : Post!{
        didSet{
             
             updateUI()
                
            }
  
        }
        
        
    
    
       
    
   
    
    func updateUI(){
        
       updateCaptionText()
        updateUsernameButton()
        updateProfilePicture()
        updateMedia()
        
    
    }

    func updateMedia(){
        if let image = post.image{
            self.photoImage.image = image
        }else{
            if let media = post.media{
                NetworkAPI.loadPicture(imageFile: media, successBlock: { (image: UIImage) in
                    self.post.image = image
                    self.photoImage.image = image
                })
            }
           
        }
    }
    
    
    func updateCaptionText(){
        var stubStr: String?
        stubStr = "Lemons"
        if let username = stubStr, let caption = post.caption{
            let captionText = "\(username) - \(caption)"
            let captionLen = captionText.characters.count
            //"First half" = username section of the string
            let firstHalfLen = username.characters.count
            //"Second half" = caption section of the string including the dash
            let secondHalfLen = captionText.characters.count
            
            let range = NSMakeRange((username.characters.count
                ), (secondHalfLen - firstHalfLen))
            
            let boldedString = TextManipulation.attributedString(from: captionText, nonBoldRange: range)
            
            captionLabel.attributedText = boldedString
        }
    
    }
    
    func updateUsernameButton(){
        if let pet = post.author{
            
                if let name = pet.name{
                     self.usernameButton.setTitle(name, for: UIControlState.normal)
                }
            
        }
    }


   func updateProfilePicture(){
    self.profilePictureButton.layer.masksToBounds = true
    self.profilePictureButton.layer.cornerRadius = profilePictureButton.frame.width/2
    
    if let pet = post.author{
            if let picture = pet.image{
                //self.profilePictureButton.imageView?.image = picture
                self.profilePictureButton.setImage(picture, for: .normal)
                //self.profilePictureButton.setImage(picture, for: .selected)
                //self.profilePictureButton.setImage(picture, for: .focused)
               // self.profilePictureButton.setBackgroundImage(picture, for: .normal)
            }
        
       
    }
    
   }



}
