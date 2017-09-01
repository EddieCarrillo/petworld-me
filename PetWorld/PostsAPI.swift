//
//  PostsAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit

class PostsAPI{
  static let path = "/posts"
  static let postMethod = "POST"
  static let getMethod = "GET"
    
    
    
    
    
   class func create(new post: Post, onFinished: (Post?, Error?) -> Void){
        let url = "\(NetworkAPI.apiBaseUrl)\(path)"
    
    }


}
