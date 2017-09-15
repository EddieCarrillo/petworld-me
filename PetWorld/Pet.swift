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
    
    var imageFile: MediaFile?
    
    
    var backgroundImageFile: MediaFile?
    
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
        self.ownerId = jsonMap["owner"] as? String
        self.objectId = jsonMap["_id"] as? String
        self.name = jsonMap["name"] as? String
        self.breed = jsonMap["breed"] as? String
        self.species = jsonMap["species"] as? String
        self.weight = jsonMap["weight"] as? NSNumber
        self.height = jsonMap["height"] as? NSNumber
        self.age = jsonMap["age"] as? NSNumber
        self.hobby = jsonMap["hobby"] as? String
        self.toy = jsonMap["toy"] as? String
        self.gender = jsonMap["gender"] as? String
        self.followersCount = jsonMap["followersCount"] as? NSNumber
        
        self.followersId = [:]
        if let followIdList = jsonMap["followers"] as? [String] {
            
            for followerId in followIdList {
                self.followersId?[followerId] = followerId
            }
            
        }
        
        self.followingId = [:]
        if let followingIdList = jsonMap["following"] as? [String] {
            for followingId in followingIdList {
                self.followingId?[followingId] = followingId
            }
        }
        
        self.likedPostsId = [:]
        if let likedPostIdList = jsonMap["likedPosts"] as? [String] {
            for likedPostId in likedPostIdList {
                self.likedPostsId?[likedPostId] = likedPostId
            }
        }
        
        if let imageId = jsonMap["image"] as? String {
            let imageFile = MediaFile()
            imageFile.objectId = imageId
            self.imageFile = imageFile
        }
        
        
        
        self.miniBio = jsonMap["miniBio"] as? String
        
        self.longBio = jsonMap["longBio"] as? String
        
        
        
        
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
        
        if let image = self.imageFile?.objectId {
            dictionary["image"]  = image
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
            dictionary["gender"] = gender
        }
        
        if let followersCount = self.followersCount{
            dictionary["followersCount"] = followersCount
        }
        
        if let followingCount = self.followingCount{
            dictionary["followingCount"] = followingCount
        }
        
        if let followers = self.followersId{
            dictionary["followers"] = followers
        }
        
        if let following = self.followingId{
             let keys: LazyMapCollection<Dictionary<String, String>, String> = following.keys
            let followIdKeys: [String] = Array(keys)
            dictionary["following"] = followIdKeys
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
        
        print("jsonBody: \(dictionary)")
        var jsonBody: Data?
        
        do{
             jsonBody = try JSONSerialization.data(withJSONObject: dictionary, options: [])
           
        }catch{
            
        }
        
        
        return jsonBody
        
    }
    
    func isFollowing(pet: Pet) -> Bool{
        
        return self.followingId![pet.objectId!] != nil
    }
    
    func addFollowing(pet toFollow: Pet){
        //Perform the follow locally and not by ID
        self.followingId?[toFollow.objectId!] = toFollow.objectId
        toFollow.followersId?[self.objectId!] = self.objectId
        self.following?[toFollow.objectId!] = toFollow
        toFollow.followers?[self.objectId!] = self
        
    }
    
    func removeFollowing(pet toUnfollow: Pet){
         //Perform the unfollow locally and not by ID
        self.followingId?.removeValue(forKey: toUnfollow.objectId!)
        self.following?.removeValue(forKey: toUnfollow.objectId!)
        toUnfollow.followersId?.removeValue(forKey: self.objectId!)
        toUnfollow.followers?.removeValue(forKey: self.objectId!)
        
    }
    
    func likePost(post: Post){
        //Perform the like locally and not by ID
        self.likedPosts?[post.objectId!] = post
        post.likedBy?[self.objectId!] = self
    
    }
    
    func unLikePost(post: Post){
        self.likedPosts?.removeValue(forKey: post.objectId!)
        post.likedBy?.removeValue(forKey: self.objectId!)
    }
    
    
    
    
}
