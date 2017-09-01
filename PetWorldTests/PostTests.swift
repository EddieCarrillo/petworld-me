//
//  PostTests.swift
//  PetWorld
//
//  Created by my mac on 9/1/17.
//  Copyright © 2017 GangsterSwagMuffins. All rights reserved.
//

import XCTest
@testable import PetWorld

class PostTests: XCTestCase {
    
    func testPostToJson(){
        let post = Post(caption: "#PUGLIF", mediaFileId: "garblegarble", authorId: "lemonlemon")
        var jsonPost = post.toJson()
        var dataPost: [String: Any]?
        do {
             dataPost = try JSONSerialization.jsonObject(with: jsonPost!, options: []) as? [String: Any]
        }catch{
             XCTFail("Could not desrialize json")
        }
        
        if let postJson = dataPost{
             var extractedPost = Post(jsonMap: postJson)
            if extractedPost.authorId == "lemonlemon" && extractedPost.caption == "#PUGLIF" && extractedPost.mediaId == "garblegarble"{
             //pass
            }else {
                XCTFail()
            }
        }else {
            XCTFail()
        }
       
    
    }
    
}
