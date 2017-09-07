    //
//  NetworkAPI.swift
//  PetWorld
//
//  Created by my mac on 7/18/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit


class NetworkAPI: NSObject {
    
  static let apiBaseUrl = "http://localhost:3000/api"
  static let authBaseUrl = "http://localhost:3000/auth"
    
    
    
//    class func loadPicture(imageFile: PFFile, successBlock: ((UIImage)->Void)? ) ->UIImage?{
//        var picture: UIImage?
//        imageFile.getDataInBackground({ (imageData:Data?, error: Error?) in
//            if let error = error{
//                print("error: \(error)")
//            }else{
//
//                let queue = OperationQueue()
//
//                if let imageData = imageData{
//                    queue.addOperation {
//                        picture = UIImage(data: imageData)
//                        OperationQueue.main.addOperation {
//                           successBlock!(picture!)
//                        }
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
    
    
    
//    class func getPhotoFile(photo: UIImage?) -> PFFile? {
//        return nil
//    }
    
    
//    class func postUserImage(photo: UIImage, caption: String?, success: PFBooleanResultBlock?) {
//
//
//    }
    
    
    class func getHomeFeed(numPosts: Int, forPet: Pet,  successHandler: @escaping ([Post])->(),  errorHandler: ((Error)->())?){
//        // Query
//        let query = PFQuery(className: "Post")
//     print(forPet)
//        let following = Array(forPet.following!.values)
//        let array = Array(forPet.following!.values)
//
//        print(array)
//        query.whereKey("author", containedIn: following)
//        query.includeKey("author")
//        query.order(byDescending: "_created_at")
//        //Populate the pet data field.
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
    
        
    class func loadCurrentUser(){}
    
   
    
//    class func loadOwner(userId: PFObject, completionHandler: @escaping ()->(), errorHandler: (()->())?){
//    }
//
//    class func loadPet(petId: PFObject, completionHandler:  (()->())?, errorHandler: (()->())?){
//
//    }
//
    
    
    
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
    
//
//    class func postComment(comment: Comment, successBlock: PFBooleanResultBlock?){
//
//
//    }
//
//
//    class func update(post: Post, withResult: @escaping PFBooleanResultBlock){
//
//    }
//
//    class func toggleLiked(withPost: Post, byPet: Pet, withState liked: Bool, completionHandler: @escaping PFBooleanResultBlock){
//
//
//    }
//
    
    
    class func follow(follower: Pet, followee: Pet, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
        
    }
    
    
    class func unfollow(follower: Pet, followee: Pet, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
        
    }
    
    class func createNewPet(withName: String, with profilePic: UIImage, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
        
        
    }
    
    
    class func createNewPet(withPet: Pet,  sucessHandler: @escaping(Pet) -> Void){
        
        
    }
    
    
    
    
    
    
    class func searchPets(withName: String, successHandler: @escaping ([Pet]) -> (Void),  errorHandler: @escaping ((Error)->Void)){
        
    }
    
    class func getPublicPosts(numPosts: Int, successHandler: @escaping(([Post]) -> Void), errorHandler:((Error) -> Void)?){
        
    }
    
    
    class func getMyPosts(numPosts: Int, successHandler: @escaping([Post]) -> Void, errorHandler: @escaping(Error) -> Void ){
        getPosts(numPosts: numPosts, forPet: Pet.currentPet()!, successHandler: successHandler, errorHandler: errorHandler)
    
    }
    
    class func getPosts(numPosts: Int, forPet: Pet, successHandler: @escaping([Post]) -> Void, errorHandler: @escaping(Error) -> Void){
        
            
  
}
    

    
    }
    
    


