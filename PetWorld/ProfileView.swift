
//
//  ProfileView.swift
//  PetWorld
//
//  Created by my mac on 4/12/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class ProfileView: UIView {
    
    var pet: Pet!{
        didSet{
            updateUI(pet: pet)
        }
    }
    
    var showEdit: Bool = false{
        didSet{
            updateEditButton(shouldShowOnScreen: showEdit)
        }
    }
    
    @IBOutlet weak var followButton: UIButton!
    
    
    
    
    @IBOutlet weak var containerView: UIView!
    
   
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    
  //  @IBOutlet weak var backgroundPictureImageView: UIImageView!
    
    @IBOutlet weak var ownerLabel: UILabel!
    
    @IBOutlet weak var miniBioLabel: UILabel!
    
    @IBOutlet weak var petNameLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    /*
    @IBOutlet weak var petAgeLabel: UILabel!
    
    @IBOutlet weak var breedLabel: UILabel!
    
    @IBOutlet weak var hobbyLabel: UILabel!
    
    @IBOutlet weak var fullBioLabel: UILabel!
    */
    
    
   
    
    
    
    
    @IBAction func onFollowTapped(_ sender: Any) {
        let isFollowing = self.followButton.isSelected
        let networkAPI = NetworkAPI.sharedInstance
        let currentPet = Pet.currentPet()!
        
        
        
        if isFollowing == true{
            
            self.followButton.isSelected = false
            currentPet.removeFollowing(pet: pet)
            networkAPI.update(pet: pet, successHandler: {
                networkAPI.update(pet: currentPet, successHandler: {
                    
                }, errorHandler: { (error: Error) in
                    print("[ERROR]: \(error)")
                })
            }, errorHandler: { (error: Error) in
                print("[ERROR]: \(error)")
            })
        
        }else{
            self.followButton.isSelected = true
            
            currentPet.addFollowing(pet: pet)
            networkAPI.update(pet: pet, successHandler: {
                networkAPI.update(pet: currentPet, successHandler: {
                    
                }, errorHandler: { (error: Error) in
                    print("[ERROR]: \(error)")
                })
            }, errorHandler: { (error: Error) in
                print("[ERROR]: \(error)")
            })
            
        }
       
        
        
        
    }
    
    
    
    
    
    func updateUI(pet: Pet){
      //  initFollowButton()
        updatePetUI(pet: pet)
        updateUserUI()
        
        
    }
    
    
    
    func updateEditButton(shouldShowOnScreen: Bool){
        if (shouldShowOnScreen){
            self.editButton.isHidden = false
            self.editButton.isEnabled = true
        }else{
            self.editButton.isHidden = true
            self.editButton.isEnabled = false
        }
    }
    
    
    
    
    
    func updateUserUI(){
        updateOwnerLabel()
    
    }
    
    
    func updateOwnerLabel(){
        let currentUser = User.current!
            self.ownerLabel.text = currentUser.username
        
    }

    
    func updatePetUI(pet: Pet){
        updatePetName(pet: pet)
        updateProfilePicture(pet :pet)
        /*updatePetAgeLabel(pet: pet)
         updateBreedLabel(pet: pet)
         updateHobbyLabel(pet: pet)
         updateFullBioLabel(pet: pet)
         updateMiniBioLabel(pet: pet)*/
        //updateBackgroundImage(pet: pet)
    }
    
    
    
    func updatePetName(pet: Pet){
        if let petName = pet.name{
            self.petNameLabel.text = petName
        }
    }
    
//    func updatePetAgeLabel(pet: Pet){
//        if let age = pet.age {
//            self.ageLabel.text = "Age: \(age)"
//        }
//    }
//    
//    func updateBreedLabel(pet: Pet){
//        if let breed = pet.breed{
//            self.text = "Breed: \(breed)"
//        }
//        
//    }
//    
//    func updateHobbyLabel(pet: Pet){
//        if let hobby = pet.hobby{
//            hobbyLabel.text = "Favorite Hobby: \(hobby)"
//        }
//    }
//    
//    func updateFullBioLabel(pet: Pet){
//        if let fullBio = pet.longBio{
//            fullBioLabel.text = "Bio: \(fullBio)"
//        }
//    }
    
    
    func updateProfilePicture(pet: Pet){
        //Extract the image and put on the scren
        if let profilePicture = pet.imageFile?.image{
            profilePictureImageView.image = profilePicture
        }
    }
    
    func updateMiniBioLabel(pet: Pet){
        if let miniBio = pet.miniBio{
            miniBioLabel.text = "\(miniBio)"
        }
    }
    
    /* func updateBackgroundImage(pet: Pet){
     if let backgroundImage = pet.backgroundImage{
     backgroundPictureImageView.image = backgroundImage
     }
     }*/
    
    
    func loadProfileImage(pet: Pet){
        //Check to see if the image of the pet was already loaded previously
       
    }
    
    func loadBackgroundImage(pet: Pet){
        //Check to see if the image of the pet was already loaded previously
       
    }
    
    
    func updateOwnerField(){
        
        let currentUser = User.current
        let username = currentUser?.username
        let ownerText = ownerLabel.text!
        
        if let username = username{
            ownerLabel.text = "\(ownerText) \(username)"
        }
    }
    //Normal = "Follow" string
    //Selected = "Unfollow" string
    
    

}
