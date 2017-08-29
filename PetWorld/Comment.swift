//
//  Comment.swift
//  PetWorld
//
//  Created by my mac on 7/22/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import Foundation
import Parse

class Comment: NSObject{
    
    public static func parseClassName() -> String {
        return "Comment"
    }
    
    //That actual text of the comment.
     var text: String?
    //Who wrote the post
     var author: Pet?
    //The post that the comment belongs to.
     var post: Post?

  
    
    

}

