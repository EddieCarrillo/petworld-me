//
//  Comment.swift
//  PetWorld
//
//  Created by my mac on 7/22/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import Foundation

class Comment: NSObject{
    
    
    
    //That actual text of the comment.
     var text: String!
    //Who wrote the post
     var author: Pet?
    var authorId: String!
    
    //The post that the comment belongs to.
     var post: Post?
    var postId: String!
    
    var objectId: String?
    
    
    init(text: String, authorId: String, postId: String){
        self.text = text
        self.authorId = authorId
        self.postId = postId
    }
    
    
    init (jsonMap: [String: Any]){
        
        if let text = jsonMap["text"] as? String{
            self.text = text
        }
        
        if let authorId = jsonMap["author"] as? String{
            self.authorId = authorId
        }
        
        if let postId = jsonMap["post"] as? String{
            self.postId = postId
        }
        
        if let objectId = jsonMap["_id"] as? String{
             self.objectId = objectId
        }
        
        
    }
    
   
    func toJson() -> Data?{
        
        let dictionary =  ["text": self.text, "author": self.authorId, "post": self.postId ]
        
        do{
            let jsonString: Data =  try JSONSerialization.data(withJSONObject: dictionary, options: [])
            return jsonString
        }catch{
            
            print("JSON processing failed")
            return nil
        }
        
    }

  
    
    

}

