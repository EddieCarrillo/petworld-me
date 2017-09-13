//
//  PostsAPI.swift
//  PetWorld
//
//  Created by my mac on 8/29/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import UIKit
@testable import PetWorld

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
                var jsonBody: [String: Any]?
                
                do{
                    jsonBody = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    
                }catch{
                    onFinished(nil, NSError(domain: "Trouble deserializing json", code: 404, userInfo: nil))
                }
                
                if let jsonPost = jsonBody{
                    let post = Post(jsonMap: jsonPost)
                    onFinished(post, nil)
                }else{
                    onFinished(nil, NSError(domain: "Trouble deserializing json", code: 404, userInfo: nil))
                }
                
                
            }
        }
    
    }
    
    
    class func getPosts(query: Query?, onFinished: @escaping ([Post]?, Error?) -> Void){
        let url: String = "\(NetworkAPI.apiBaseUrl)\(path)"
        GeneralNetworkAPI.get(urlString: url, token: nil, queryParams: query) { (data: Data?, error: Error?) in
            if let error = error {
                onFinished(nil, error)
                return;
            }else if let data = data {
                print("data: \(data)")
                var postsJson: [[String: Any]]?
                do{
                    postsJson = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    if let postsJson = postsJson {
                        var posts: [Post] = []
                        for postJson in postsJson{
                            let post  = Post(jsonMap: postJson)
                            print(postJson)
                            posts.append(post)
                        }
                        onFinished(posts, nil)
                    }
                }catch{
                    onFinished(nil, NSError(domain: "Could not deserailize json", code: 404, userInfo: nil ))
                }
                
            }
        }
    }
    
    class func get(post byId: String, onFinished: @escaping(Post?, Error?) -> Void){
        let url: String = "\(NetworkAPI.apiBaseUrl)\(path)/id/\(byId)"
    GeneralNetworkAPI.get(urlString: url, token: nil, queryParams: nil) { (data: Data?, error: Error?) in
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
    
    
    
//    class func update(post: Post, token: String, onFinished: @escaping(Post?, Error?) -> ()){
//        let url = "\(NetworkAPI.apiBaseUrl)\(path)"
//        guard let jsonPost = post.toJson() else {
//            onFinished(nil, NSError(domain: "Could not get json", code: 404, userInfo: nil))
//            return;
//        }
//        
//        GeneralNetworkAPI.put(urlString: url, requestBody: jsonPost, token: token) { (data Data?, error: Error?) in
//            if let error = error {
//                onFinished(nil, error)
//            }else if let data = data{
//                var jsonResponsePost: [String: Any]?s
//                do {
//                    jsonResponsePost = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
//                    if let jsonResponsePost = jsonResponsePost{
//                        let post = Post(jsonMap: jsonResponsePost)
//                        onFinished(post, nil)
//                    }
//                }catch{
//                    onFinished(nil, NSError(domain: "Could not convert to object", code: 404, userInfo: nil))
//                }
//            }
//        }
//    }

}
