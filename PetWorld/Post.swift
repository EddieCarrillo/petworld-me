//
//  Post.swift
//  PetWorld
//
//  Created by Vinnie Chen on 5/16/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    /**
     The name of the class as seen in the REST API.
     */
    public static func parseClassName() -> String {
         return "Post"
    }

    
  
    var petName: String?
    var author : Pet?
    var media: PFFile?
    var caption: String?
     var likes: NSNumber?
     var likedBy: [String: Pet]?
    var comments: [Comment]?
    var timeStamp : String?
    var image: UIImage?
    //Flag to check and see if a post is currently liked by the current Pet logged in
    var liked: Bool = false
    var objectId: String?
    
   
    
    
}


