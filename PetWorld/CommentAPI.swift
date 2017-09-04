//
//  CommentAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class CommentAPI{
    static var path = "/comments"
    static var getMethod = "GET"
    static var postMethod = "POST"
    
    
    class func getComments(from postId: String, onFinished: ([Comment]?, Error?) -> Void){
        
    
    }
    
    class func create(comment: Comment, for postId: Post, onFinished: (Comment?, Error?) -> Void){
    
        
    }
    
    
    
    
    

}
