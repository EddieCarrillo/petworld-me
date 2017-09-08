//
//  Pet.swift
//  PetWorld
//
//  Created by my mac on 5/15/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class Pet: NSObject  {
    
    static var pets: [Pet] = []
  
    static var currentPetIdx = 0
    
     var owner: User?
    
    var ownerId: String?
    
    //Profile pictre
    var image: UIImage?
    //Background profile picture
    var backgroundImage: UIImage?
    
     var name: String?
    
     var breed: String?
    
     var species: String?
    
     var weight: NSNumber?
    
     var height: NSNumber?
    
     var age: NSNumber?
    //Animals's favorite hobby
     var hobby: String?
    //Animal's favorite toy
     var toy: String?
    //Male or female none of this 55 gender stuff.
     var gender: String?
    //Don't be a folllower be a leader.
     var followersCount: NSNumber?
    //Increase this.
     var followingCount: NSNumber?
    //Minions
     var followers: [String: Pet]?
      //Id of followers
    var followersId: [String: String]?
    //Idols
     var following: [String:Pet]?
    //Id of idols
    var followingId: [String: String]?
    //Mini bio (32 characters max)
      var miniBio: String?
    //Long bio (256 characters max)
      var longBio: String?
    //Pet's liked post
     var likedPosts: [String: Post]?
    //Ids of liked posts
    var likedPostsId: [String: String]?
    
    
    var objectId: String?
    
     init(jsonMap: [String: Any]){
        print("json to be deconstructed: \(jsonMap)")
<<<<<<< HEAD
        self.ownerId = jsonMap["owner"] as? String
        self.objectId = jsonMap["_id"] as? String
        self.name = jsonMap["name"] as? String
=======
        self.ownerId = jsonMap["owner"] as! String?
        self.objectId = jsonMap["_id"] as! String?
        self.name = jsonMap["name"] as! String?
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
    }
    
    init(name: String, ownerId: String){
         self.name = name
         self.ownerId = ownerId
        self.likedPostsId = [:]
        self.likedPosts = [:]
        self.followingId = [:]
        self.following = [:]
        self.followers = [:]
        self.followersId = [:]
        
    }
   
   
   
    
//    func constructor(petObject: PFObject){
//        NetworkAPI.loadPicture(imageFile: petObject["image"] as! PFFile, successBlock: { (image: UIImage) in
//            self.image = image
//        })
//        self.owner = petObject["owner"] as! PFUser?
//        self.name = petObject["name"] as! String?
//        self.breed = petObject["breed"] as! String?
//        self.species = petObject["species"] as! String?
//        self.weight = petObject["weight"] as! NSNumber?
//        self.height = petObject["height"] as! NSNumber?
//        self.age = petObject["age"] as! NSNumber?
//        self.hobby = petObject["hobby"] as! String?
//        self.toy = petObject["toy"] as! String?
//        self.gender = petObject["gender"] as! String?
//        self.followers = petObject["followers"] as! NSNumber?
//        self.following = petObject["following"] as! NSNumber?
//        self.miniBio = petObject["miniBio"] as! String?
//        self.longBio = petObject["longBio"] as! String?
//    }
    
    //Class functions.....
    class func currentPet() -> Pet?{
        let defaults = UserDefaults.standard
        
        let currentPetIndex = defaults.integer(forKey: "currentPet") ?? 0
        
        let pets = getPets()
        
        if pets.count > 0{
          return  pets[currentPetIndex]
        }else{
            return nil
        }
        
        
      
        
    }
    
    class func add(newPet: Pet){
        Pet.pets.append(newPet)
    }
    
    
    class func getPets() -> [Pet]{
        
        
        return Pet.pets
    }
    
     func toJson() -> Data?{
        var dictionary: [String: Any] = [:]
        
        if let name = self.name{
            dictionary["name"] = name
        }
        
        if let ownerId = self.ownerId{
           dictionary["owner"] = ownerId
        }
        
        if let breed = self.breed{
            dictionary["breed"] = breed
        }
        
        if let species = self.species{
            dictionary["species"] = species
        }
        
        if let weight = self.weight{
            dictionary["weight"] = weight
        }
        
        if let height = self.height{
            dictionary["height"] = height
        }
        
        if let age = self.age{
            dictionary["age"] = age
        }
        
        if let hobby = self.hobby{
            dictionary["hobby"] = hobby
        }
        
        if let toy = self.toy{
            dictionary["toy"] = toy
        }
        
        if let gender = self.gender{
            dictionary["geneder"] = gender
        }
        
        if let followersCount = self.followersCount{
            dictionary["followersCount"] = followersCount
        }
        
        if let followingCount = self.followingCount{
            dictionary["followingCount"] = followingCount
        }
        
        if let followers = self.followersId{
            dictionary["followers"] = followingCount
        }
        
        if let following = self.followingId{
            dictionary["following"] = following
        }
        
        if let miniBio = self.miniBio{
            dictionary["miniBio"] = miniBio
        }
        
        if let longBio = self.longBio{
            dictionary["longBio"] = longBio
        }
        
        if let likedPostsId = self.likedPostsId{
            dictionary["likedPosts"] = likedPostsId
        }
        
        var jsonBody: Data?
        
        do{
             jsonBody = try JSONSerialization.data(withJSONObject: dictionary, options: [])
           
        }catch{
            
        }
        
        
        return jsonBody
        
        
        
        
    }
    
    
    
    
    
   
    
    func isFollowing(pet: Pet) -> Bool{
        if self.following == nil{
            following = [:]
        }
        
        if pet.followers == nil{
            followers = [:]
        }
        
        return self.following![pet.objectId!] != nil
    }
    
    
    
    
}
