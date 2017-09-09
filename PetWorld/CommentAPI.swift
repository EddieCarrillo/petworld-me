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
    
    
    class func getComments(from postId: String, queryParams: Query?, onFinished: @escaping([Comment]?, Error?) -> Void){
        let url = "\(NetworkAPI.apiBaseUrl)\(path)"
        GeneralNetworkAPI.get(urlString: url, token: nil, queryParams: queryParams) { (data: Data?, error: Error?) in
            if let error = error{
                onFinished(nil, NSError(domain: "Couldn't create comment.", code: 404, userInfo: [:]))
                return;
            }else if let data = data{
                var jsonBody: [[String: Any]]?
                
                do {
                    jsonBody = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                }catch{
onFinished(nil, NSError(domain: "Couldn't create from json repsonse.", code: 404, userInfo: [:]))                }
                
                if let jsonBody = jsonBody{
                    var comments: [Comment] = []
                    for jsonComment in jsonBody{
                        let comment = Comment(jsonMap: jsonComment)
                        comments.append(comment)
                    }
                    
                    onFinished(comments, nil)
                }else {
                    onFinished(nil, NSError(domain: "Couldn't create from json repsonse.", code: 404, userInfo: [:]))
                }
                
                
                
            }
            }
        }
    
    
    class func create(comment: Comment, token: String, for postId: String, onFinished: @escaping(Comment?, Error?) -> Void){
        let jonRogawskiId = "59aef169256ec2132ea6a392"
        let postId = "59aef4fd256ec2132ea6a39b"
        let comment1 = Comment(text: "I am comment 1.", authorId: jonRogawskiId, postId: postId)
//         let comment2 = Comment(text: "I am comment 1.", authorId: jonRogawskiId, postId: postId)
//         let comment3 = Comment(text: "I am comment 1.", authorId: jonRogawskiId, postId: postId)
        guard  let comment1Json = comment1.toJson() else {
            onFinished(nil, NSError(domain: "Could convert to json", code: 404, userInfo: nil))
            return;
        }
        
        GeneralNetworkAPI.post(urlString: "\(NetworkAPI.apiBaseUrl)\(path)", requestBody: comment1Json, token: token) { (data: Data?, error: Error?) in
            if let error = error{
                onFinished(nil, error)
            }else if let data = data {
                var commentJson: [String: Any]?
                do {
                    commentJson = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                }catch{
                    onFinished(nil, NSError(domain:
                        "Trouble converting json to object", code: 404, userInfo: nil))
                }
                
                if let commentJson = commentJson{
                    let comment = Comment(jsonMap: commentJson)
                    print("comment: \(comment)")
                     onFinished(comment, nil)
                }else {
                    onFinished(nil, NSError(domain:
                        "Trouble converting json to object", code: 404, userInfo: nil))
                }
            }
        }
    }
    
    
    class func getComments(from postId: String, onFinished: ([Comment]?, Error?) -> Void){
        
    
    }
    
    class func create(comment: Comment, for postId: Post, onFinished: (Comment?, Error?) -> Void){
    
        
    }
    
    
    
    
    

}
