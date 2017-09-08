//
//  Post.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/16/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit



class Post: NSObject {
   

    
  
    var authorName: String?
    var author : Pet?
    var authorId: String!
    var mediaFile: MediaFile?
    var mediaId: String!
//    var media: PFFile?
    var caption: String!
     var likes: NSNumber?
     var likedBy: [String: Pet]?
    var likedById:[String: String]?
    //To be deleted
    var comments: [Comment]?
    var commentsId: [String]?
    ////////////////////////
    var timeStamp : String?
    var image: UIImage?
    //Flag to check and see if a post is currently liked by the current Pet logged in
    var liked: Bool = false
    
    var objectId: String?
    

    override init(){
        super.init()
    //Stub
    
    }

init(caption: String, mediaFileId: String, authorId: String){
    self.caption = caption
    self.mediaId = mediaFileId
    self.authorId = authorId
}
<<<<<<< HEAD
    
    init(caption: String, authorId: String){
        self.caption = caption
        self.authorId = authorId
    }

=======
>>>>>>> e31c44122ab2d46bc376642fd254377a5819ab31

//Unpopulated fields init
init(jsonMap: [String: Any]){
    if let caption = jsonMap["caption"] as? String{
         self.caption = caption
    }
    
    if let mediaId = jsonMap["media"] as? String{
        self.mediaId = mediaId
    }
    
    if let authorId = jsonMap["author"] as? String{
         self.authorId = authorId
    }
}


func toJson() -> Data?{
    
    let dictionary = ["caption": self.caption, "media": self.mediaId, "author": self.authorId]
    do{
       let jsonPost = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        return jsonPost
    }catch{
        return nil
    }
    
    

}

}


