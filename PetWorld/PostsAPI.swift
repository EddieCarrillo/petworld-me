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
  static let badJSONSerialization = 404
    
    
    
    
    
    class func create(new post: Post, token: String, onFinished: @escaping(Post?, Error?) -> Void){
        let url = "\(NetworkAPI.apiBaseUrl)\(path)"
    guard let postBody = post.toJson() else {
        onFinished(nil, NSError(domain: "Trouble deserializing json", code: 404, userInfo: nil))
        return;
        
    }
        GeneralNetworkAPI.post(urlString: url, requestBody: postBody, token: token) { (data: Data?, error: Error?) in
            if let error = error {
                onFinished(nil, NSError(domain: "Trouble deserializing json", code: 404, userInfo: nil))
            }else if let data = data{
                var jsonPostRes: [String: Any]?
                
                do{
                    jsonPostRes = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                }catch{
                    onFinished(nil, NSError(domain: "Trouble deserializing json", code: 404, userInfo: nil))
                    
                }
                
                if let jsonPost = jsonPostRes{
                    let post = Post(jsonMap: jsonPost)
                    onFinished(post, nil)
                }else{
                    onFinished(nil, NSError(domain: "Trouble deserializing json", code: 404, userInfo: nil))
                }
                
                
            }
        }
    
    }
    
   class func get(post byId: String, onFinished: @escaping(Post?, Error?) -> Void){
        let url: String = "\(NetworkAPI.apiBaseUrl)\(path)/\(byId)"
    GeneralNetworkAPI.get(urlString: url, token: nil) { (data: Data?, error: Error?) in
        if let error = error{
            onFinished(nil, error)
            return;
        }else if let data = data{
            print("data: \(data)")
            var postJson: [String: Any]?
            do{
                postJson =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
            }catch{
                onFinished(nil, NSError(domain: "Trouble deserializing json", code: 404, userInfo: nil))
                
            }
            
            if let postJson = postJson{
                let post = Post(jsonMap: postJson)
                onFinished(post, nil)
            }else{
                onFinished(nil, NSError(domain: "Trouble deserializing json", code: 404, userInfo: nil))
            }
        }
        } 
        
    }


}
