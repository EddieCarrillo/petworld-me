//
//  Pet.swift
//  PetWorld
//
//  Created by my mac on 5/15/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class Pet: PFObject, PFSubclassing {
    
    static var pets: [Pet] = []
  
    static var currentPetIdx = 0
    
    var owner: PFUser?
    
    //Profile pictre
    var image: UIImage?
    //Background profile picture
    var backgroundImage: UIImage?
    //Name of the pet.
    @NSManaged var name: String?
    
    @NSManaged var breed: String?
    
    @NSManaged var species: String?
    
    @NSManaged var weight: NSNumber?
    
    @NSManaged var height: NSNumber?
    
    @NSManaged var age: NSNumber?
    //Animals's favorite hobby
    @NSManaged var hobby: String?
    //Animal's favorite toy
    @NSManaged var toy: String?
    //Male or female none of this 55 gender stuff.
    @NSManaged var gender: String?
    //Don't be a folllower be a leader.
    @NSManaged var followers: NSNumber?
    //Increase this.
    @NSManaged var following: NSNumber?
    //Mini bio (32 characters max)
    @NSManaged  var miniBio: String?
    //Long bio (256 characters max)
    @NSManaged  var longBio: String?
   
    
    //Class functions.....
    class func currentPet() -> Pet{
        let defaults = UserDefaults.standard
        
        let currentPetIndex = defaults.integer(forKey: "currentPet") ?? 0
        
        let pets = getPets()
        
        if pets.count > 0{
          return  pets[currentPetIndex]
        }
        //Stub pet
        return Pet()
        
        
        
        
    }
    
    class func add(newPet: Pet){
        Pet.pets.append(newPet)
    }
    
    
    class func getPets() -> [Pet]{
        
        
        return Pet.pets
    }
    
    static func parseClassName() -> String {
        return "Pet"
    }
    
}
