    //
//  NetworkAPI.swift
//  PetWorld
//
//  Created by my mac on 7/18/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
    
//    (success: Bool, error: Error?)
typealias PFBooleanResultBlock =  (Bool?, Error?) -> ();


class NetworkAPI: NSObject {
    
  static let apiBaseUrl = "http://localhost:3000/api"
  static let authBaseUrl = "http://localhost:3000/auth"
  static let badTokenCode = 1997
  static let authTokenKey = "AUTH_TOKEN_KEY"
  static let needLoginNotification = "NEED_LOGIN_NOTIFICATION"
    
  static let sharedInstance = NetworkAPI()
    
    var needLogin: Bool = false
    var authToken: String?
    
    
    private override init(){
        //Get auth token from local storage
         self.authToken = NetworkAPI.getStoredToken()
    }
    
    
    //Check to see if there is token persisted in local storage, if there is 
    // then check to see if it is valid.
    func isTokenValid(completionHandler: @escaping(Bool) -> Void){
        guard let token = self.authToken else {
            print("No token saved locally")
             completionHandler(false)
            return;
        }
        
        AuthAPI.checkValid(token: token) { (freshUser: User?, error: Error?) in
            if let error = error{
                completionHandler(false)
                print("[ERROR]: \(error)")
            }else if let user = freshUser {
                User.current = user
                completionHandler(true)
                self.needLogin = false
            }else {
                completionHandler(false)
                self.needLogin = true
            }
        }
        
    }
    
    
    
    
    

    
     func loadPicture(imageFile: MediaFile, successBlock: ((UIImage)->Void)? ) ->UIImage?{
        FileAPI.get(imageId: imageFile.objectId!, success: { (image: UIImage) in
            if let successBlock = successBlock{
                successBlock(image)
            }
        }) { (error: Error) in
            print(error)
        }

        return nil
    }


    
    
    
    func loadPets(finishedDownloading: @escaping ([Pet])->Void, errorHandler: @escaping(Error) -> Void){
        guard let currentUser = User.current else {
            errorHandler(NSError(domain: "Could not get current user", code: 404, userInfo: nil))
            return;
        }
        
        let query = Query()
        query.whereKey(key: "owner", equals: currentUser.objectId )
        
        PetsAPI.getPets(queryParams: query) { (pets: [Pet]?, error: Error?) in
            if let error = error{
                errorHandler(error)
            }else if let pets = pets{
                finishedDownloading(pets)
            }
        }
        
    }
    
    
//     func postUserImage(photo: UIImage, caption: String?, success: PFBooleanResultBlock?) {
//        
//        
//    }
//    
    
     func getHomeFeed(numPosts: Int, forPet: Pet,  successHandler: @escaping ([Post])->(),  errorHandler: ((Error)->())?){
        guard let keys: LazyMapCollection<Dictionary<String, Pet>, String> = forPet.following?.keys else {
            
            if let errorHandler = errorHandler{
                errorHandler(NSError(domain: "User has no followers", code: 404, userInfo: nil))
            }
            print("User is not following anybody.")
            return;
        }
        
        let following: [String] = Array(keys)
        let query = Query()

        
        query.whereKey(key: "author" , containedIn: following)
        
        PostsAPI.getPosts(query: query) { (posts: [Post]?, error: Error?) in
            if let error = error{
                if let errorHandler = errorHandler{
                    errorHandler(error)
                }
            }else if let posts = posts{
                 successHandler(posts)
            }
        }
        
        
        
    }
    
     func loadCurrentUser(){}
    

   
    
    
    class func loadPet(petId: String, completionHandler:  ((Pet)->())?, errorHandler: ((Error)->())?){
        PetsAPI.getPet(with: petId) { (pet: Pet?, error: Error?) in
            if let error = error {
                if let errorHandler = errorHandler{
                    errorHandler(error)
                }
            }else if let pet = pet{
                if let completionHandler = completionHandler {
                    completionHandler(pet)
                }
            }
        }
    }
    
    
    
    
     func resize(photo: UIImage, newSize: CGSize) -> UIImage {
        
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
    
    
     func getComments(withPost: Post, populateFields: Bool, successHandler: @escaping([Comment])->(),  errorHandler: @escaping(Error)->() ){
        let postId = withPost.objectId
        
        CommentAPI.getComments(from: postId!, queryParams: nil) { (comments: [Comment]?, error: Error?) in
            if let error = error{
                 errorHandler(error)
            }else if let comments = comments{
                 successHandler(comments)
            }else {
                 errorHandler(NSError(domain: "Something weird happened", code: 404, userInfo: nil))
            }
        }
       
        }
    
    
     func postComment(comment: Comment, successBlock: PFBooleanResultBlock?){
        let token  = "stub"
        let stubPostId = "stubby"
        CommentAPI.create(comment: comment, token: token, for: stubPostId) { (comment: Comment?, error: Error?) in
            if let error = error {
                successBlock!(false, error)
            }else if let comment = comment {
                 successBlock! (true, nil)
            }else {
                successBlock!(false, NSError(domain: "Something weird happened", code: 404, userInfo: nil))
            }
        }
        
    }
    
    
     func toggleLiked(withPost: Post, byPet: Pet, withState liked: Bool, completionHandler: @escaping PFBooleanResultBlock){
        let token = "STUB"
        byPet.likePost(post: withPost)
        PetsAPI.put(pet: byPet, withId: byPet.objectId!, token: token) { (pet: Pet?, error: Error?) in
            if let error = error {
                 completionHandler(false, error)
            }else if let pet = pet {
                 completionHandler(true, nil)
            }else {
                 completionHandler(false, NSError(domain: "Could not get the current user", code: 404, userInfo: nil))
            }
        }
    }
    
  

    
    
//     func follow(follower: Pet, followee: Pet, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
//        let token = "stub"
//        
//        follower.addFollowing(pet: followee)
//        
//        PetsAPI.put(pet: follower, withId: follower.objectId!, token: token) { (updatedPet: Pet?, error: Error?) in
//            if let error = error {
//                errorHandler(error)
//            }else if let pet = updatedPet{
//                completionHandler()
//            }else {
//                errorHandler( NSError(domain: "Could not get current user", code: 404, userInfo: nil))
//            }
//        }
//        
//    }
    
//    
//     func unfollow(follower: Pet, followee: Pet, completionHandler: @escaping((Void) -> Void), errorHandler: @escaping((Error)-> Void)){
//        let token = "STUB"
//        let id = "STUB"
//        
//        follower.removeFollowing(pet: followee)
//        
//        PetsAPI.put(pet: follower, withId: id, token: token) { (updatedPet: Pet?, error: Error?) in
//            if let error = error {
//                errorHandler(error)
//            }else if let pet = updatedPet{
//                completionHandler()
//            }else {
//                errorHandler(NSError(domain: "Something weird happened.", code: 404, userInfo: nil))
//            }
//        }
//        
//      
//        
//    }

    
    
    
     func createNewPet(withName: String, with profilePic: UIImage, completionHandler: @escaping PFBooleanResultBlock){
        guard let currentUser = User.current else {
            completionHandler(false, NSError(domain: "Could not get current user", code: 404, userInfo: nil))
            return;
        }
        
        
        //Pet stub
        let pet = Pet(name: withName, ownerId: currentUser.objectId!)
        let token = "stub"
        PetsAPI.postCreate(newPet: pet, token: token) { (createdPet: Pet?, error: Error?) in
            if let error = error{
                  completionHandler(false, error)
            }else if let pet = createdPet{
                completionHandler(true, nil)
            }else {
                 completionHandler(false, NSError(domain: "Could not get current user", code: 404, userInfo: nil))
            }
        }
    }
    
    
     func createNewPet(withPet: Pet, completionHandler: @escaping PFBooleanResultBlock){
        guard let currentUser = User.current else {
            completionHandler(false, NSError(domain: "Could not get the current user", code: 404, userInfo: nil))
            return;
        }
        
        let token = "stub"

        
        PetsAPI.postCreate(newPet: withPet, token: token) { (createdPet: Pet?, error: Error?) in
            if let error = error {
                
                 completionHandler(false, error)
            }else if let pet = createdPet{
                completionHandler(true, error)
            }else {
                 completionHandler(false, NSError(domain: "Something weird happened", code: 404, userInfo: nil))
            }
        }
        
        
    }

    
    
    
    
    
     func searchPets(withName: String, successHandler: @escaping ([Pet]) -> (Void),  errorHandler: @escaping ((Error)->Void)){
        guard let currentPet = Pet.currentPet() else {
             print("No current pet.")
            return;
        }
        
        let query = Query()
        query.whereKey(key: "name", hasPrefix: withName, caseInsensitive: true)
        
        PetsAPI.getPets(queryParams: query) { (pets: [Pet]?, error: Error?) in
            if let error = error {
                errorHandler(error)
            }else if let pets = pets {
                 successHandler(pets)
            }else {
                errorHandler(NSError(domain: "Something weird happened", code: 404, userInfo: nil))
            }
        }
        
    }
    
     func getPublicPosts(numPosts: Int, successHandler: @escaping(([Post]) -> Void), errorHandler:((Error) -> Void)?){
        
        guard let currentPet: Pet = Pet.currentPet() else {
            errorHandler!(NSError(domain: "Could not get the current pet.", code: 404, userInfo: nil))
            return;
            
        }
        
        getPosts(numPosts: numPosts, forPet: currentPet, successHandler: successHandler, errorHandler: errorHandler!)
        
    }
    
    
     func getMyPosts(numPosts: Int, successHandler: @escaping([Post]) -> Void, errorHandler: @escaping(Error) -> Void ){
        guard let currentUser = User.current else {
             print("No user currently logged in.")
            errorHandler(NSError(domain: "No user currently logged in.", code: 404, userInfo: nil))
            return;
        }
        
        let query = Query()
        query.whereKey(key: "owner", equals: currentUser.objectId)
        
        
        PostsAPI.getPosts(query: query) { (posts: [Post]?, error: Error?) in
            if let error = error{
                errorHandler(error)
            }else if let posts = posts{
                successHandler(posts)
            }else {
                errorHandler(NSError(domain: "Something weird happened", code: 404, userInfo: nil))

            }
        }
        
    
    }
    
    func update(pet: Pet, successHandler: @escaping ()->(), errorHandler:  ((Error) -> ())?){
        PetsAPI.put(pet: pet, withId: pet.objectId!, token: self.authToken!) { (pet: Pet?, error: Error?) in
            if let error = error {
                if let errorHandler = errorHandler{
                    errorHandler(error)
                }
            }else if let pet = pet {
                successHandler()    
            }
        }
    }
    
    
    func create(newPost: Post, successHandler: @escaping ()->(),  errorHandler: @escaping (Error)->()){
        guard let token = self.authToken else {
            errorHandler(NSError(domain: "No auth token", code: 404, userInfo: nil))
            return;
        }
        
        PostsAPI.create(new: newPost, token: token) { (createdPost: Post?, error: Error?) in
            if let error = error{
                errorHandler(error)
            }else if let post  = createdPost {
                print("[POST]: \(post) saved")
                successHandler()
            }
        }
    }
    
    
    
     func getPosts(numPosts: Int, forPet: Pet, successHandler: @escaping([Post]) -> Void, errorHandler: @escaping(Error) -> Void){
        PostsAPI.getPosts(query: nil) { (posts: [Post]?, error: Error?) in
            if let error = error {
               errorHandler(error)
            }else if let posts = posts{
                successHandler(posts)
            }else {
                 errorHandler(NSError(domain: "Something weird happened", code: 404, userInfo: nil))
            }
        }
  }
    
    
    func login (with username: String, and password: String,  completionHandler: @escaping(Bool, Error?) -> ()){
        AuthAPI.login(username: username, password: password) { (token: String?, error: Error?) in
            if let error = error {
                completionHandler(false, error)
            }else if let token = token {
                self.authToken = token
                self.saveAuthToken(token: token)
                completionHandler(true, nil)
                self.needLogin = false
            }
        }
    }
    
    func signUp (with username: String, and password: String,  completionHandler: @escaping (Bool, Error?) -> () ) {
        let newUser = User(username: username, email: "", password: password)
        UserAPI.signUp(new: newUser) { (token: String?, error: Error?) in
            if let error = error{
              
                    completionHandler(false, error)
                
            }else if let token = token{
                //Save the auth token
                self.saveAuthToken(token: token)
               
                completionHandler(true, nil)
                
                
                self.needLogin = false
            }
        }
    }
    
    
    func uploadImageFile(image: UIImage, successHandler: @escaping (MediaFile) -> (), errorHandler: @escaping(Error) -> ()){
        
        FileAPI.post(image: image, success: { (fileId: String) in
            let newImage: MediaFile = MediaFile()
            newImage.image = image
            newImage.objectId = fileId
            successHandler(newImage)
        }) { (error: Error) in
            errorHandler(error)
        }
        
    }
    
    
   private class func getStoredToken() -> String?{
        return UserDefaults.standard.string(forKey: NetworkAPI.authTokenKey)
    }
    
    private func saveAuthToken(token: String){
        //Save in app
        self.authToken = token
        //Save in storage
        UserDefaults.standard.set(token, forKey: NetworkAPI.authTokenKey)
    }
    
    
    
    
    
    
    
    
    
            
  
}
    

    
    
    
    


