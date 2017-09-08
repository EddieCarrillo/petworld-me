    //
//  NetworkAPI.swift
//  PetWorld
//
//  Created by my mac on 7/18/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
<<<<<<< HEAD
    
//    (success: Bool, error: Error?)
typealias PFBooleanResultBlock =  (Bool?, Error?) -> ();
=======

>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31

class NetworkAPI: NSObject {
    
  static let apiBaseUrl = "http://localhost:3000/api"
  static let authBaseUrl = "http://localhost:3000/auth"
    
    
<<<<<<< HEAD
//
=======
    
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
//    class func loadPicture(imageFile: PFFile, successBlock: ((UIImage)->Void)? ) ->UIImage?{
//        var picture: UIImage?
//        imageFile.getDataInBackground({ (imageData:Data?, error: Error?) in
//            if let error = error{
//                print("error: \(error)")
//            }else{
<<<<<<< HEAD
//
//                let queue = OperationQueue()
//
=======
//                
//                let queue = OperationQueue()
//               
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
//                if let imageData = imageData{
//                    queue.addOperation {
//                        picture = UIImage(data: imageData)
//                        OperationQueue.main.addOperation {
//                           successBlock!(picture!)
//                        }
<<<<<<< HEAD
//
//                    }
//
//                }
//            }
//
//        }) { (int: Int32) in
//            print("totalProgress: \(int)%")
//        }
//
//
//        return picture
//
//
//    }
//
//
    
    
    
    class func loadPets(finishedDownloading: @escaping ([Pet])->Void){
        
    }
=======
//                        
//                    }
//                    
//                }
//            }
//            
//        }) { (int: Int32) in
//            print("totalProgress: \(int)%")
//        }
//        
//        
//        return picture
//        
//        
//    }
    
    

    
    
    class func loadPets(finishedDownloading: @escaping ([Pet])->Void){
        
            }
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
    
    
    
//    class func getPhotoFile(photo: UIImage?) -> PFFile? {
//        return nil
//    }
    
    
<<<<<<< HEAD
    class func postUserImage(photo: UIImage, caption: String?, success: PFBooleanResultBlock?) {
        
        
    }
    
    
    class func getHomeFeed(numPosts: Int, forPet: Pet,  successHandler: @escaping ([Post])->(),  errorHandler: ((Error)->())?){
        // Query
=======
//    class func postUserImage(photo: UIImage, caption: String?, success: PFBooleanResultBlock?) {
//       
//        
//    }
    
//    
//    class func getHomeFeed(numPosts: Int, forPet: Pet,  successHandler: @escaping ([Post])->(),  errorHandler: ((Error)->())?){
//        // Query
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
//        let query = PFQuery(className: "Post")
//     print(forPet)
//        let following = Array(forPet.following!.values)
//        let array = Array(forPet.following!.values)
<<<<<<< HEAD
//
=======
//        
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
//        print(array)
//        query.whereKey("author", containedIn: following)
//        query.includeKey("author")
//        query.order(byDescending: "_created_at")
//        //Populate the pet data field.
<<<<<<< HEAD
//
//
//
//        query.limit = numPosts
//
//
//        query.findObjectsInBackground { (postObjects: [PFObject]?, error: Error?) in
//
//    }
        
    }
=======
//        
//    
//        
//        query.limit = numPosts
//        
//        
//        query.findObjectsInBackground { (postObjects: [PFObject]?, error: Error?) in
//           
//    }
//    
//    }
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
    
        
    class func loadCurrentUser(){}
    
<<<<<<< HEAD
//   
//    
//    class func loadOwner(userId: PFObject, completionHandler: @escaping ()->(), errorHandler: (()->())?){
//    }
//    
//    class func loadPet(petId: PFObject, completionHandler:  (()->())?, errorHandler: (()->())?){
//        
//    }
    
=======
   
    
//    class func loadOwner(userObject: PFObject, completionHandler: @escaping ()->(), errorHandler: (()->())?){
//    }
//    
//    class func loadPet(petObject: PFObject, completionHandler:  (()->())?, errorHandler: (()->())?){
//       
//    }
//    
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
    
    
    
    class func resize(photo: UIImage, newSize: CGSize) -> UIImage {
        
        //Resize the image to match the siize that is passed in
        let resizedImage = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizedImage.contentMode = UIViewContentMode.scaleAspectFill
        resizedImage.image = photo
        
        //update the image on the view controller to the new size
        UIGraphicsBeginImageContext(resizedImage.frame.size)
        resizedImage.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    class func getComments(withPost: Post, populateFields: Bool, successHandler: @escaping([Comment])->(),  errorHandler: @escaping(Error)->() ){
        
       
        }
    
<<<<<<< HEAD
    
    class func postComment(comment: Comment, successBlock: PFBooleanResultBlock?){
        
        
    }
    
    
    class func update(post: Post, withResult: @escaping PFBooleanResultBlock){
        
    }
    
    class func toggleLiked(withPost: Post, byPet: Pet, withState liked: Bool, completionHandler: @escaping PFBooleanResultBlock){
        
        
    }
    
=======
//    
//    class func postComment(comment: Comment, successBlock: PFBooleanResultBlock?){
//        
//        
//    }
//    
    
//    class func update(post: Post, withResult: @escaping PFBooleanResultBlock){
//      
//    }
    
//    class func toggleLiked(withPost: Post, byPet: Pet, withState liked: Bool, completionHandler: @escaping PFBooleanResultBlock){
//        
//        
//    }
//    
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
    
    
    class func follow(follower: Pet, followee: Pet, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
        
    }
    
    
    class func unfollow(follower: Pet, followee: Pet, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
        
    }
    
<<<<<<< HEAD
    class func createNewPet(withName: String, with profilePic: UIImage, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
        
        
    }
    
    
    class func createNewPet(withPet: Pet,  sucessHandler: @escaping(Pet) -> Void){
        
        
    }
    
=======
//    class func createNewPet(withName: String, with profilePic: UIImage, completionHandler: @escaping PFBooleanResultBlock){
//        
//    
//    }
//    
//    
//    class func createNewPet(withPet: Pet, completionHandler: @escaping PFBooleanResultBlock){
//        
//        
//    }

>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
    
    
    
    
    
    class func searchPets(withName: String, successHandler: @escaping ([Pet]) -> (Void),  errorHandler: @escaping ((Error)->Void)){
        
    }
    
    class func getPublicPosts(numPosts: Int, successHandler: @escaping(([Post]) -> Void), errorHandler:((Error) -> Void)?){
        
    }
    
    
    class func getMyPosts(numPosts: Int, successHandler: @escaping([Post]) -> Void, errorHandler: @escaping(Error) -> Void ){
        getPosts(numPosts: numPosts, forPet: Pet.currentPet()!, successHandler: successHandler, errorHandler: errorHandler)
    
    }
    
    class func getPosts(numPosts: Int, forPet: Pet, successHandler: @escaping([Post]) -> Void, errorHandler: @escaping(Error) -> Void){
<<<<<<< HEAD
     
  }
=======
        
            
  
}
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31
    

    
    }
    
    


